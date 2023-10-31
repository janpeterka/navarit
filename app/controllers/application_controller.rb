class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    Current.user = if Rails.env.production?
                     User.find_by(id: session[:user_id])
                   elsif Rails.env.development?
                     User.first
                   end
  end
end
