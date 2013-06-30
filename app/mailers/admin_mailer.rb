class AdminMailer < ActionMailer::Base
  default from: "admin@devbootcampmentorship.com"
  layout "mailer"

  def test_email
    mail(to: "brett.coding@gmail.com", subject: "Test Email!")
  end

  def notify_pair(mentor, mentee)
    return unless mentor && mentee
    to = "#{mentor.email}, #{mentee.email}"
    mail(to: to, subject: "DevBootcamp Mentor Pairing!", cc: "john@devbootcamp.com, brett@devbootcamp.com")
  end
end
