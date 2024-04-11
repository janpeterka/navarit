# frozen_string_literal: true

module Buttons
  class ButtonLinkComponent < ::ApplicationComponent
    include ButtonDefaults

    attr_reader :name, :path, :icon, :type, :updated_options, :options, :size

    def initialize(name:, path:, icon: nil, type: :primary, size: :default, **options)
      raise ArgumentError, "Unsupported button type" if DEFAULT_BUTTON_CLASSES.keys.exclude?(type)
      raise ArgumentError, "Unsupported button size" if DEFAULT_SIZE_CLASSES.keys.exclude?(size)

      super

      @icon = icon
      @name = name
      @path = path
      @type = type
      @size = size
      @options = options || {} # this is passed to ButtonToComponent
      @updated_options = arguments_with_updated_default_class(classes, **options)
    end

    private

    def classes
      "#{DEFAULT_CLASSES[@type]} #{DEFAULT_SIZE_CLASSES[@size]}"
    end
  end
end
