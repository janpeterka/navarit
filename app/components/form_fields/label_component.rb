class FormFields::LabelComponent < BaseComponent
  attr_reader :label

  def initialize(label, **html_attributes)
    super(**html_attributes)
    @label = label
  end

  def default_classes(part = :base)
    case part
    when :base
      'block mb-2 text-sm font-medium text-gray-900'
    else
      raise "Unknown part: #{part}"
    end
  end
end
