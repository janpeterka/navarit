# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_nearest_future_event, only: %i[show]

  def show; end

  private

  def set_nearest_future_event
    @nearest_future_event = current_user.events.future.order(:date_from).first
  end
end
