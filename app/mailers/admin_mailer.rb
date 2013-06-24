class AdminMailer < ActionMailer::Base
  default from: "admin@devbootcampmentorship.com"

  def test_email
    mail(:to => “brett.coding@gmail.com”, :subject => “Test Email!”)
  end
end
