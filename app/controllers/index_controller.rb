# frozen_string_literal: true

class IndexController < PublicApplicationController
  def show
    return unless current_user.present?

    redirect_to dashboard_path
  end
end
