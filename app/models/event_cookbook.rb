# frozen_string_literal: true

class EventCookbook
  include ActiveModel::Model

  attr_reader :event, :recipes, :days

  def initialize(event)
    @event = event
    @days = (@event.date_from..@event.date_to)
  end
end
