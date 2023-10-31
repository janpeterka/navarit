class Reactions::ReactionSectionComponent < ApplicationComponent
  attr_reader :object

  def initialize(object, **)
    @object = object
  end
end
