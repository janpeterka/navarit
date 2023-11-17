# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current_user

  def set_current_user
    Current.user = if Rails.env.production?
                     User.find_by(id: session[:user_id])
                   elsif Rails.env.development?
                     User.first
                   elsif Rails.env.test?
                     User.first || FactoryBot.create(:user)
                   end
  end
end
