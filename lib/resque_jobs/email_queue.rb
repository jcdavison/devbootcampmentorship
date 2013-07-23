class EmailQueue
  @queue = :high

  def self.perform(message, user_id)
    mail = AdminMailer.send_message(message, user_id)
    mail.deliver if mail
  end
end