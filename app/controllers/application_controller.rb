# frozen_string_literal: true

class ApplicationController < PublicApplicationController
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :authorize_rack_mini_profiler

  def authorize_rack_mini_profiler
    return unless current_user && current_user.admin?

    Rack::MiniProfiler.authorize_request
  end
end
