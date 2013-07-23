class EmailQueue
  @queue = :high

  def self.perform(message, user)
    mail = AdminMailer.send_message(message, user.id)
    mail.deliver if mail
  end
end