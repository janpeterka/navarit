# frozen_string_literal: true

module Buttons
  # Component for the link_to helper with default admin button style.
  class ButtonLinkComponent < ::ApplicationComponent
    include ButtonDefaults

    attr_reader :name, :path, :type, :options

    def initialize(name:, path:, type: :primary, **options)
      raise ArgumentError, 'Unsupported button type' if DEFAULT_BUTTON_CLASSES.keys.exclude?(type)

      super

      @name = name
      @path = path
      @type = type
      @options = options || {}
    end

    def call
      updated_options = arguments_with_updated_default_class(DEFAULT_CLASSES[type], **options)

      if content
        link_to(path, **updated_options) { content }
      else
        link_to(name, path, **updated_options)
      end
    end
  end
end
