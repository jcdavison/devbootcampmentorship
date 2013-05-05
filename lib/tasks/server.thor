class Dev < Thor
  include Thor::Actions

  desc "server", "Starts the local dev server on specified port or 3000"
  def server(port=3000)
    run "unicorn -p #{port}"
  end

end