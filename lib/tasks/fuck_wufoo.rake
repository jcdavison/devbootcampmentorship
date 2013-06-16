ACCOUNT = 'devbootcamp'
API_KEY = 'X1HQ-ZU20-12O7-0SD9'
FORM = "dev-bootcamp-mentor-application"
namespace :wu do
  task :run  => :environment do
    wufoo = WuParty.new(ACCOUNT, API_KEY)
    form = wufoo.form(FORM)
    all_entries = form.all_entries
    all_entries.each { |user| User.process_wufoo_user(user)}
  end

end
