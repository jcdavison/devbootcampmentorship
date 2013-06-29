class AdminMailer < ActionMailer::Base
  default from: "admin@devbootcampmentorship.com"

  def test_email
    mail(to: "brett.coding@gmail.com", subject: "Test Email!")
  end

  def notify_pair(to, content)
    @content = content
    mail(to: to, subject: "test email")
  end
end
