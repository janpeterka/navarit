# frozen_string_literal: true

class PublicApplicationController < ActionController::Base
  include Pagy::Backend

  layout "application"

  rescue_from CanCan::AccessDenied do |exception|
    Rails.error.handle(context: { message: "Forbidden access", url: request.url, user_id: current_user&.nil }, severity: :info)

    raise CanCan::AccessDenied
  end

  if Rails.env.development?
    around_action :n_plus_one_detection

    def n_plus_one_detection
      Prosopite.scan
      yield
    ensure
      Prosopite.finish
    end
  end
end
