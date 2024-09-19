class AdminController < ApplicationController
  before_action :authenticate_admin

  def error
    p 1/0
  end

  private

  def authenticate_admin
    redirect_to root_path unless current_user.admin?
  end
end
