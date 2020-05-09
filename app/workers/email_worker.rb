class EmailWorker < ApplicationJob
  queue_as :mailer

  def perform(user_id, message)
    mail = PostNotifier.post_update_email(user_id, message)
    mail.deliver_now
  end
end