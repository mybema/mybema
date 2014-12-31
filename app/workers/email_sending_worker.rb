class EmailSendingWorker
  include Sidekiq::Worker

  def perform resource_id
    user = User.find resource_id
    MybemaDeviseMailer.send_welcome(user).deliver
  end
end