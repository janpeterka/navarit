class CardComponent < ApplicationComponent
  include Turbo::FramesHelper

  attr_reader :object, :classes, :name

  renders_one :heading
  renders_one :actions
  renders_one :details
  renders_one :body

  def initialize(object = nil, shadow: true, **options)
    super
    # @object = object
    @name = object if object.is_a? String
    @classes = options[:class]
    @classes += " card-shadow" if shadow
  end
end
