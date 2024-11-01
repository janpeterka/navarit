class IndexController < PublicApplicationController
  def show
    return unless current_user.present?

    redirect_to dashboard_path
  end

  def changelog
  end
end
