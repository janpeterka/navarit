# frozen_string_literal: true

module Badges
  class BadgeComponent < ApplicationComponent
    attr_reader :value, :kwargs, :bg_class, :color_class

    def initialize(value:, color:, **kwargs)
      super
      @value = value
      @kwargs = kwargs
      @color_class = get_color_class(color)
    end

    private

    def get_color_class(color)
      "bg-#{color}-500"
    end
  end
end
