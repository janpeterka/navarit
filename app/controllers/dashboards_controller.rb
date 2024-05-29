# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @nearest_future_event = current_user.events.future.order(:date_from).first
    @showcased_public_recipes = Recipe.published.includes(:labels, :author, :category, :reactions).order(created_by: :desc).limit(3)
  end
end
