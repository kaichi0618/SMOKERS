class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where(checked: false).page(params[:page]).per(20)
  end
end
