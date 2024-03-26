# frozen_string_literal: true

# This is not a component because buttons themselves should be preferrably used only via simple_form.
# Instead, this is a module containing the default button classes.
module Buttons
  module ButtonDefaults
    DEFAULT_BUTTON_TO_FORM_CLASSES = 'inline-flex justify-center items-center'
    SHARED_DEFAULT_BUTTON_CLASSES = "inline-block align-middle text-center select-none
                                     font-normal whitespace-no-wrap rounded-lg
                                     py-1 px-3 leading-normal no-underline ps-2 pe-2 p-1 me-2 mb-2 mt-1
                                     border border-2
                                     focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-ocean-300
                                     disabled:bg-gray-200
                                    ".squish
    DEFAULT_BUTTON_CLASSES = {
      primary: "#{SHARED_DEFAULT_BUTTON_CLASSES}
                text-white bg-ocean-500 border-ocean-500
                hover:bg-ocean-700 hover:border-ocean-700
                disabled:hover:text-black
               ".squish,
      secondary: "#{SHARED_DEFAULT_BUTTON_CLASSES}
                  text-ocean-500 border-ocean-500
                  hover:bg-ocean-700 hover:text-white hover:border-ocean-700
                ".squish,
      plain: "#{SHARED_DEFAULT_BUTTON_CLASSES}
              border-transparent text-ocean-500
              hover:bg-ocean-100
      ".squish,
      dangerous: "#{SHARED_DEFAULT_BUTTON_CLASSES} border-red-600 hover:bg-red-600 hover:text-white".squish
    }.freeze

    DEFAULT_CLASSES = DEFAULT_BUTTON_CLASSES.transform_values do |classes|
      "#{DEFAULT_BUTTON_TO_FORM_CLASSES} #{classes}"
    end.to_h
  end
end
