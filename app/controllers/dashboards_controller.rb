# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @nearest_future_event = current_user.events.future.order(:date_from).first
  end
end
