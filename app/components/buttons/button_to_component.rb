# frozen_string_literal: true

module Buttons
  # Component for the button_to helper with default admin style.
  class ButtonToComponent < ButtonLinkComponent
    def call
      options[:form_class] ||= DEFAULT_BUTTON_TO_FORM_CLASSES
      updated_options = helpers.arguments_with_updated_default_class(DEFAULT_BUTTON_TO_FORM_CLASSES, prefix: "form",
                                                                                                     **options)
      updated_options2 = helpers.arguments_with_updated_default_class(classes, **updated_options)

      if content
        content.prepend(helpers.icon(@icon, class: "w-4 h-4 mr-2 inline")) if @icon.present?

        button_to(path, **updated_options2) { content }
      else
        @name = helpers.safe_join([ helpers.icon(@icon, class: "w-4 h-4 mr-2 inline"), @name ]) if @icon.present?

        button_to(name, path, **updated_options2)
      end
    end
  end
end
