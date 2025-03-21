class DashboardsController < ApplicationController
  def show
    @nearest_future_event = current_user.events.future.order(:date_from).first
    @showcased_public_recipes = Recipe.published.without_shopping
                                      .includes(:labels, :author, :category, :reactions)
                                      .order(created_at: :desc).limit(3)
  end
end
