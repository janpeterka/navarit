# frozen_string_literal: true

# This component renders a menu with multiple items.
class MenuComponent < ApplicationComponent
  renders_many :items, lambda { |name = nil, path, **kwargs, &block|
    default_classes = "border-transparent text-gray-500 whitespace-nowrap
                         py-4 px-1 border-b-2 font-medium text-sm"

    if current_path.to_s.start_with?(path)
      default_classes.gsub!('text-gray-500', '')
      default_classes << ' text-blue-600 border-blue-500'
    else
      default_classes << ' hover:border-gray-300 hover:text-gray-700'
    end

    if block
      link_to path, **helpers.arguments_with_updated_default_class(default_classes, **kwargs), &block
    else
      link_to name, path, **helpers.arguments_with_updated_default_class(default_classes, **kwargs)
    end
  }

  attr_reader :current_path

  def initialize(current_path: nil)
    super
    @current_path = current_path
  end
end
