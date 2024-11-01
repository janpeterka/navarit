module Feedback
  class AdminController < ApplicationController
    before_action :authenticate_admin!

    private

    def authenticate_admin!
      redirect_to main_app.root_path unless current_user.try(:admin?)
    end
  end
end
