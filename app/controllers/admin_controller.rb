class AdminController < ApplicationController
  before_action :authenticate_admin

  def index
  end

  def error
    p 1/0
  end

  def access_denied
    raise CanCan::AccessDenied
  end

  private

  def authenticate_admin
    redirect_to root_path unless current_user.admin?
  end
end
