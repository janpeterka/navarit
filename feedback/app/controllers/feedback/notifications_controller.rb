module Feedback
  class NotificationsController < ApplicationController
    def index
      @notifications = Notification.all
    end

    def show
      @notification = Notification.find(params[:id])
    end

    def destroy
      @notification = Notification.find(params[:id])

      @notification.mark_read!

      redirect_back_or_to index_url, status: :see_other
    end
  end
end
