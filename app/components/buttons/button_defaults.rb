# frozen_string_literal: true

# This is not a component because buttons themselves should be preferrably used only via simple_form.
# Instead, this is a module containing the default button classes.
module Buttons
  module ButtonDefaults
    DEFAULT_BUTTON_TO_FORM_CLASSES = "inline-flex justify-center items-center".freeze

    SHARED_DEFAULT_BUTTON_CLASSES = "inline-block align-middle text-center select-none
                                     font-normal whitespace-no-wrap rounded-lg
                                     leading-normal no-underline me-2 mb-2 mt-1
                                     border border-2
                                     focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-ocean-300
                                     disabled:bg-gray-200
                                    ".squish.freeze

    DEFAULT_BUTTON_CLASSES = {
      primary: "text-white bg-ocean-500 border-ocean-500
                hover:bg-ocean-700 hover:border-ocean-700
                disabled:hover:text-black".squish,
      secondary: "text-ocean-500 border-ocean-500
                  hover:bg-ocean-700 hover:text-white hover:border-ocean-700".squish,
      plain: "border-transparent text-ocean-500
              hover:bg-ocean-100".squish,
      dangerous: "border-red-600 hover:bg-red-600
                  hover:text-white".squish
    }.freeze

    DEFAULT_SIZE_CLASSES = {
      default: "py-1 px-3 ps-2 pe-2".freeze,
      small: "py-0.5 px-2 ps-1 pe-1".freeze
    }

    DEFAULT_CLASSES = DEFAULT_BUTTON_CLASSES.transform_values do |classes|
      "#{SHARED_DEFAULT_BUTTON_CLASSES} #{classes}"
    end.to_h
  end
end
