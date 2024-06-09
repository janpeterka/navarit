module DefaultFormHelper
  def default_form_for(object, *args, &block)
    default_form_class = "grid grid-cols-1 gap-x-4 gap-y-6 items-start sm:grid-cols-12"
    options = args.extract_options!
    options[:html] ||= {}
    options[:html][:class] = default_form_class + " " + options[:html][:class].to_s # TODO: should use smart merge
    # options[:html][:class] = arguments_with_updated_default_class(default_form_class, **options[:form] || {})
    # options[:wrapper] = :plain
    options[:builder] = Builders::DefaultFormBuilder

    simple_form_for(object, **options, &block)
  end
end
