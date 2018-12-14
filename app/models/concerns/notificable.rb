module Notificable
  extend ActiveSupport::Concern

  included do # los métodos que se deben ejecutar con la clase (ej. callbacks)
    has_many :notifications, as: :item
    after_commit :send_notification_to_users 
  end

  def send_notification_to_users
    if self.respond_to? :user_ids
      # JOB send notifications async
      # 1. Create post
      # 2. Create a job to send notifications
      # 3. Respond/Reply with the post, show it.... etc
      # ....
      # 4. Send notifications (async)
      
      NotificationSenderJob.perform_later(self)
      # NotificationSenderJob.set(wait: 5.minutes).perform()
    end
  end
end
