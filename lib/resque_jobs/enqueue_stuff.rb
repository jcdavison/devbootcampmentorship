class EnqueueStuff
  include Resque::Plugins::UniqueJob

  @queue = :low

  def self.perform
    Rails.logger.info "WHEEEEE"
  end
end