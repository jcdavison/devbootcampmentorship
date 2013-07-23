class KeyValueStore
  def connect
    if Rails.env.test?
      @redis = MockRedis.new
    else
      uri = URI.parse(ENV["REDISTOGO_URL"])
      @redis = Redis.new(host: uri.host, port: uri.port, password: uri.password, db: uri.path[1..-1].to_i)
    end
  end

  private

  def initialize
    if ENV["REDISTOGO_URL"]
      connect
    else
      @redis = nil
    end
  end

  def method_missing(meth, *args, &block)
    begin
      raise"Attempted to call non-existent REDIS method \"#{meth}\"" unless @redis.respond_to?(meth)

      # Rails.logger.debug "REDIS: Calling #{meth}(#{args})"

      return @redis.send(meth, *args, &block)
    rescue => ex
      Rails.logger.error ex
      Rails.logger.error ex.backtrace.join("\n")
      raise ex
    end
  end
end

$redis = REDIS = KeyValueStore.new

Resque.redis = REDIS
Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/schedule.yml'))

require 'resque-retry'
require 'resque/failure/redis'

Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression

Resque.after_fork do |job|
  ActiveRecord::Base.connection_handler.verify_active_connections!
end
