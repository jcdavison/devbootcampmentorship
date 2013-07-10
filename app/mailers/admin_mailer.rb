class AdminMailer < ActionMailer::Base
  default from: "admin@devbootcampmentorship.com"
  layout "mailer"
  CC_LINE = "john@devbootcamp.com, brett@devbootcamp.com, sherif@devbootcamp.com"

  def test_email
    mail(to: "brett.coding@gmail.com", subject: "Test Email!")
  end

  def welcome(user)
    @user = user
    @cohort = Cohort.next
    return unless @user && @cohort
    mail(to: @user.email, subject: "Welcome to the Dev Bootcamp Mentorship community", cc: CC_LINE )
  end

  def notify_pair(mentor, mentee, cohort_name)
    return unless mentor && mentee && cohort_name
    @mentor = mentor
    @mentee = mentee
    to = "#{@mentor.email}, #{@mentee.email}"
    mail(to: to, subject: "DevBootcamp Mentor Pairing re #{cohort_name}!", cc: CC_LINE)
  end

  def notify_pair_destruction(mentor, mentee)
    return unless mentor && mentee
    @mentor = mentor
    @mentee = mentee
    to = "#{@mentor.email}, #{@mentee.email}"
    mail(to: to, subject: "DevBootcamp Mentor Pairing, Its a Break Up..", cc: CC_LINE)
  end
end
