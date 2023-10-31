# frozen_string_literal: true

module Reactions
  class ReactionButtonComponent < ApplicationComponent
    attr_reader :text, :value, :selected, :path, :kwargs, :icon_url

    def initialize(text:, value:, path:, selected:, **kwargs)
      super
      @text = text
      @value = value
      @selected = selected
      @path = path
      @kwargs = kwargs
    end
  end
end
