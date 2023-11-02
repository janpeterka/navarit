# frozen_string_literal: true

# This is not a component because buttons themselves should be preferrably used only via simple_form.
# Instead, this is a module containing the default button classes.
module Buttons
  module ButtonDefaults
    DEFAULT_BUTTON_TO_FORM_CLASSES = 'inline-flex justify-center items-center'
    DEFAULT_BUTTON_CLASSES = {
      primary: 'inline-block align-middle text-center select-none border font-normal whitespace-no-wrap rounded-lg
                py-1 px-3 leading-normal no-underline border-emerald-600
                hover:bg-emerald-600 hover:text-white
                ps-2 pe-2 p-1 me-2 mb-2 lg:mb-0'.squish,
      secondary: "px-4 py-2 text-sm font-medium bg-white rounded-md
                border border-gray-300 text-gray-700 hover:bg-gray-50 focus:ring-2 focus:ring-offset-2
                focus:ring-offset-gray-100 focus:ring-indigo-500 shadow-sm focus:outline-none".squish,
      dangerous: 'inline-block align-middle text-center select-none border font-normal whitespace-no-wrap rounded-lg
                  py-1 px-3 leading-normal no-underline border-red-600
                  hover:bg-red-600 hover:text-white
                  ps-2 pe-2 p-1 me-2 mb-2 lg:mb-0'.squish
    }.freeze

    DEFAULT_CLASSES = DEFAULT_BUTTON_CLASSES.transform_values do |classes|
      "#{DEFAULT_BUTTON_TO_FORM_CLASSES} #{classes}"
    end.to_h
  end
end
