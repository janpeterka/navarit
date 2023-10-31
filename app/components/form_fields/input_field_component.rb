class FormFields::InputFieldComponent < BaseComponent
  attr_reader :size

  def initialize(size: :base, **html_attributes)
    super(**html_attributes)
    @size = size
  end

  def default_classes(part = :base)
    case part
    when :base
      class_names("block w-full text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500
                    focus:border-blue-500", size_classes(size:).to_s)
    else
      raise "Unknown part: #{part}"
    end
  end

  private

  def size_classes(size: :base)
    case size
    when :small
      'p-2 sm:text-xs'
    when :base
      'p-2.5 text-sm'
    when :large
      'p-4 sm:text-md'
    else
      raise "Unknown size: #{size.inspect}"
    end
  end
end
