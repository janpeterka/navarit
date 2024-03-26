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
                    'bg-green-300'
                  when 'strong-highlight'
                    'bg-orange-300'
                  else
                    'bg-peach-300'
                  end
    end
  end
end
