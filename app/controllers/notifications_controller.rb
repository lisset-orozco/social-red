class NotificationsController < ApplicationController
  def index
    @notifications = Notification.get_notifications(current_user).latest
    #@notifications = Notification.where(user: current_user).unviewed

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @notification = Notification.find_by(id: params[:id])

    message = if @notification.update(notification_params)
      "Notificación vista"
    else
      "Hubo un error"
    end
    redirect_to :back, notice: message
  end

  private

  def notification_params
    params.require(:notification).permit(:viewed)
  end
end
