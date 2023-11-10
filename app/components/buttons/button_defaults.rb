# frozen_string_literal: true

# This is not a component because buttons themselves should be preferrably used only via simple_form.
# Instead, this is a module containing the default button classes.
module Buttons
  module ButtonDefaults
    DEFAULT_BUTTON_TO_FORM_CLASSES = 'inline-flex justify-center items-center'
    SHARED_DEFAULT_BUTTON_CLASSES = "inline-block align-middle text-center select-none
                                     border border-2 font-normal whitespace-no-wrap rounded-lg
                                     py-1 px-3 leading-normal no-underline ps-2 pe-2 p-1 me-2 mb-2 mt-1"
    DEFAULT_BUTTON_CLASSES = {
      primary: "#{SHARED_DEFAULT_BUTTON_CLASSES}
                border-emerald-600 hover:bg-emerald-600 hover:text-white
                disabled:border-cyan-800 disabled:hover:bg-white disabled:hover:text-black".squish,
      secondary: "#{SHARED_DEFAULT_BUTTON_CLASSES} border-gray-800 hover:bg-gray-600 hover:text-white".squish,
      dangerous: "#{SHARED_DEFAULT_BUTTON_CLASSES} border-red-600 hover:bg-red-600 hover:text-white".squish
    }.freeze

    DEFAULT_CLASSES = DEFAULT_BUTTON_CLASSES.transform_values do |classes|
      "#{DEFAULT_BUTTON_TO_FORM_CLASSES} #{classes}"
    end.to_h
  end
end
