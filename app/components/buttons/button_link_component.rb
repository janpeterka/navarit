# frozen_string_literal: true

module Buttons
  class ButtonLinkComponent < ::ApplicationComponent
    include ButtonDefaults

    attr_reader :name, :path, :icon, :type, :updated_options, :options, :size

    def initialize(name: nil, path: nil, icon: nil, type: :primary, size: :default, override_classes: false, **options)
      raise ArgumentError, "Unsupported button type (allowed: #{DEFAULT_BUTTON_CLASSES.keys.join(", ")})" if DEFAULT_BUTTON_CLASSES.keys.exclude?(type)
      raise ArgumentError, "Unsupported button size (allowed: #{DEFAULT_SIZE_CLASSES.keys.join(", ")})" if DEFAULT_SIZE_CLASSES.keys.exclude?(size)

      super

      @icon = icon
      @name = name
      @path = path
      @type = type
      @size = size
      @options = options || {} # this is passed to ButtonToComponent
      @updated_options = if override_classes
                            options
                         else
                            arguments_with_updated_default_class(classes, **options)
                         end
    end

    private

    def classes
      "#{DEFAULT_CLASSES[@type]} #{DEFAULT_SIZE_CLASSES[@size]}"
    end
  end
end
