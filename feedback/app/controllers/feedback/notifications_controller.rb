module Feedback
  class NotificationsController < ApplicationController
    # GET /notifications
    def index
      @notifications = Notification.all
    end

    # GET /notifications/1
    def show
      @notification = Notification.find(params[:id])
    end

    # DELETE /notifications/1
    def destroy
      @notification = Notification.find(params[:id])

      @notification.mark_read!

      redirect_back_or_to index_url, notice: "Notification was marked read.", status: :see_other
    end
  end
end
