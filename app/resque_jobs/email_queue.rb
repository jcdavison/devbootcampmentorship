class EmailQueue
  @queue = :email_queue

  def self.perform(message, user)
    mail = AdminMailer.send_message(message, user)
    mail.deliver if mail
  end
end