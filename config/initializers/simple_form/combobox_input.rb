# Integrates Hotwire combobox with SimpleForm.
class ComboboxInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    if options[:collection].blank? && !Rails.env.test?
      raise ArgumentError, "Usage: f.input :attribute, as: :combobox, label: '...', collection: [...],
                            input_html: { value: '...' } [, multiselect_chip_src: path_to_chips]".squish
    end

    unless string?
      input_html_classes.unshift("string")
      input_html_options[:type] ||= input_type if html5?
    end

    input_html_options.delete(:maxlength)

    combobox_options = {
      value: input_html_options.delete(:value) || default_input_value,
      input: merge_wrapper_options(input_html_options, wrapper_options)
    }

    if options[:multiselect_chip_src].present?
      combobox_options[:multiselect_chip_src] = options[:multiselect_chip_src]
      combobox_options[:input][:multiple] = "multiple" # needed for proper styling
    end

    @builder.template.combobox_tag(@builder.field_name(attribute_name), options[:collection], **combobox_options)
  end

  private

  # determine the default value, possibly take it from a flags_column
  def default_input_value
    input_object = @builder.object
    return unless input_object

    attribute_value = input_object.public_send(attribute_name)

    if input_object.class.respond_to?(:flags_column?) && input_object.class.flags_column?(attribute_name)
      # convert flags mask to comma-separated flag values
      input_object.public_send(:"list_#{attribute_name}")
                  .map { input_object.class.public_send(:"all_#{attribute_name}", strip: false)[_1] }
                  .map(&:to_s).join(",")
    elsif attribute_value.is_a?(Array) || attribute_value.is_a?(ActiveRecord::Relation)
      attribute_value.join(",")
    else
      attribute_value
    end
  end
end
