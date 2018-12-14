class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notitication)
    user_id = notitication.user_id
    notitication_count = Notification.for_user(user_id)

    ActionCable.server.broadcast "notifications.#{user_id}",
                                 { action: 'new_notification', 
                                  message: notitication_count }
  end
end
