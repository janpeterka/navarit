class FormFields::TextAreaComponent < BaseComponent
  def default_classes(part = :base)
    case part
    when :base
      "block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500
         focus:border-blue-500"
    else
      raise "Unknown part: #{part}"
    end
  end
end
