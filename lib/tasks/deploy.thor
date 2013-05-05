class Deploy < Thor
  include Thor::Actions

  desc "prod", "Deploy to heroku production"
  def prod
    run "git push -f heroku master"
    run "heroku run rake db:migrate"
  end
end