# frozen_string_literal: true

module Reactions
  class ReactionSectionComponent < ApplicationComponent
    attr_reader :object

    def initialize(object, **)
      @object = object
    end
  end
end
