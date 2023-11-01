# frozen_string_literal: true

module Badges
  class LabelBadgeComponent < ApplicationComponent
    attr_reader :label, :kwargs, :bg_class

    def initialize(label:, **kwargs)
      super
      @label = label
      @kwargs = kwargs
      set_bg_class
    end

    def set_bg_class
      @bg_class = case label.color
                  when 'highlight'
                    'bg-yellow-500'
                  when 'strong-highlight'
                    'bg-red-500'
                  else
                    'bg-green-500'
                  end
    end
  end
end
