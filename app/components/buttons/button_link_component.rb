# frozen_string_literal: true

module Buttons
  class ButtonLinkComponent < ::ApplicationComponent
    include ButtonDefaults

    attr_reader :name, :path, :icon, :type, :updated_options, :options

    def initialize(name:, path:, icon: nil, type: :primary, **options)
      raise ArgumentError, 'Unsupported button type' if DEFAULT_BUTTON_CLASSES.keys.exclude?(type)

      super

      @icon = icon
      @name = name
      @path = path
      @type = type
      @options = options || {} # this is passed to ButtonToComponent
      @updated_options = arguments_with_updated_default_class(DEFAULT_CLASSES[type], **options)
    end
  end
end
