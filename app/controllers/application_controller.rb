# frozen_string_literal: true

class ApplicationController < PublicApplicationController
  include Pagy::Backend

  # before_action :set_current_user
  before_action :authenticate_user!

  # def set_current_user
  #   current_user
  #   # current_user = if Rails.env.production?
  #   #                  User.find_by(id: session[:user_id])
  #   #                elsif Rails.env.development?
  #   #                  User.first
  #   #                elsif Rails.env.test?
  #   #                  User.first || FactoryBot.create(:user)
  #   #                end
  # end
end
