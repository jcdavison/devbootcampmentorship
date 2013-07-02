class AdminMailer < ActionMailer::Base
  default from: "admin@devbootcampmentorship.com"
  layout "mailer"

  def test_email
    mail(to: "brett.coding@gmail.com", subject: "Test Email!")
  end

  def notify_pair(mentor, mentee, cohort_name)
    return unless mentor && mentee && cohort_name
    @mentor = mentor
    @mentee = mentee
    to = "#{@mentor.email}, #{@mentee.email}"
    mail(to: to, subject: "DevBootcamp Mentor Pairing re #{cohort_name}!", cc: "john@devbootcamp.com, brett@devbootcamp.com")
  end

  def notify_pair_destruction(mentor, mentee)
    return unless mentor && mentee
    @mentor = mentor
    @mentee = mentee
    to = "#{@mentor.email}, #{@mentee.email}"
    mail(to: to, subject: "DevBootcamp Mentor Pairing, Its a Break Up..", cc: "john@devbootcamp.com, brett@devbootcamp.com")
  end
end
