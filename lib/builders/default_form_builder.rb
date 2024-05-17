module Builders
  class DefaultFormBuilder < SimpleForm::FormBuilder
    # This is the basic method for rendering `<input>` tags and their variants.
    def input(attribute_name, options = {}, &block)
      # The default Tailwind classes for the various parts of the Simple Form wrapper layout.
      input_class = "block px-2.5 pb-2.5 pt-3 w-full"
      input_class += " rounded-2xl"
      # input_class = "block px-2.5 pb-2.5 pt-5 w-full dark:bg-gray-700 border-0 border-b-2 border-gray-300 appearance-none peer"
      # input_class += " sm:text-sm rounded-md"
      # input_class += " focus:outline-none focus:ring-0 focus:border-emerald-700"
      # input_class += " text-gray-500 bg-gray-200" if options.dig(:input_html, :disabled) || options.dig(:disabled)

      input_wrapper_class = "mt-1"
      wrapper_class = ""
      label_wrapper_class = ""
      hint_class = "mt-2 text-sm ..."
      error_class = "mt-2 text-sm text-red-700 ..."

      # set "empty" (but not nil) placeholder for floating labels
      unless options[:placeholder].present?
        options[:input_html] =
          { placeholder: "" }.merge(options[:input_html] || {})
      end

      case options[:as]
      when :boolean
        input_class = "focus:ring-indigo-500 ..."

        options[:boolean_style] ||= :inline
        # options[:wrapper] ||= :plain_boolean

        # input_wrapper_class = 'flex h-10 ...'

      when :file
        input_class = "block w-full file:px-4 file:py-2 ..."

      when :date, :datetime
        options[:html5] = options.fetch(:html5, true) # use HTML5 date/time inputs by default
      end

      options = convert_col_span_argument_to_class(**options)
      options[:input_html] = arguments_with_updated_default_class(input_class, **(options[:input_html] || {}))
      options[:input_wrapper_html] = arguments_with_updated_default_class(input_wrapper_class,
                                                                          **(options[:input_wrapper_html] || {}))
      options[:wrapper_html] = arguments_with_updated_default_class(wrapper_class,
                                                                    **options[:wrapper_html] || {})
      options[:label_wrapper_html] = arguments_with_updated_default_class(label_wrapper_class,
                                                                          **(options[:label_wrapper_html] || {}))
      options[:hint_html] = arguments_with_updated_default_class(hint_class, **(options[:hint_html] || {}))
      options[:error_html] = arguments_with_updated_default_class(error_class, **(options[:error_html] || {}))

      super(attribute_name, options, &block)
    end

    # Renders the label for the given form field.
    def label(attribute_name, *args, &block)
      options = args.extract_options!.dup

      default_class = "absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-4 scale-75 top-4 z-10 origin-[0] start-2.5 peer-focus:text-emerald-700 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-4 rtl:peer-focus:translate-x-1/4 rtl:peer-focus:left-auto"

      # default_class = 'block text-sm font-medium'
      options = arguments_with_updated_default_class(default_class, **options)

      super(attribute_name, *[ args.first, options ], &block)
    end

    # Renders a generic button. A submit button is handled by the method below instead.
    def button(type, *args, &block)
      return super(type, *args, &block) if type == :submit # submit buttons are delegated to the `submit` method below

      button_options = args.extract_options!.dup
      default_classes = "px-4 py-2 text-sm font-medium bg-white rounded-md ..."

      button_options = convert_col_span_argument_to_class(key: nil, **button_options)
      button_options = arguments_with_updated_default_class(default_classes, **button_options)
      args << button_options

      super(type, *args, &block)
    end

    # Renders a submit button.
    def submit(value = nil, options = {})
      default_classes = Buttons::ButtonDefaults::DEFAULT_CLASSES[:primary]
      default_classes += " #{Buttons::ButtonDefaults::DEFAULT_SIZE_CLASSES[:default]}"
      # default_classes = 'px-4 py-2 text-sm font-medium border border-emerald-700 rounded-md ...'

      button_options = convert_col_span_argument_to_class(key: nil, **options)
      button_options = arguments_with_updated_default_class(default_classes, **button_options)

      super(value, button_options)
    end

    def cancel_link(path: nil, target: nil, **)
      href = if path
               path
             elsif target
               Rails.application.routes.url_helpers.polymorphic_path(target)
             else
               Rails.application.routes.url_helpers.polymorphic_path(object)
             end

      default_classes = Buttons::ButtonDefaults::DEFAULT_CLASSES[:secondary]
      default_classes += " #{Buttons::ButtonDefaults::DEFAULT_SIZE_CLASSES[:default]}"

      @template.content_tag(:a, "zrušit", href:, class: default_classes, **)
    end

    def buttons_section(**buttons_options, &block)
      default_classes = "flex justify-end sm:col-span-full gap-x-3 sm:py-3 sm:px-4 sm:px-6 sm:-mx-6 sm:-mb-6 sm:rounded-b-md"

      @template.content_tag(:div, arguments_with_updated_default_class(default_classes, **buttons_options)) do
        simple_fields_for(object_name, object, &block)
      end
    end

    def cancel_link(path: nil, target: nil, **options)
      href = if path
              path
             elsif target
              Rails.application.routes.url_helpers.polymorphic_path(target)
             else
              Rails.application.routes.url_helpers.polymorphic_path(object)
             end

      classes = "#{Buttons::ButtonDefaults::DEFAULT_CLASSES[:plain]} #{Buttons::ButtonDefaults::DEFAULT_SIZE_CLASSES[:default]}"

      @template.content_tag(:a, "zrušit", href:, class: classes, **options)
    end

    private

    # This helper converts the `col_span` parameter to a Tailwind `col-span-X` class in the keyword args.
    # By default, it adds the class to the wrapper element (see the `key` parameter) and not on mobile devices
    # (see the `class_prefix` parameter). It returns amended (and dup-ed) kw arguments.
    def convert_col_span_argument_to_class(key: :wrapper_html, class_prefix: "sm:", **kwargs)
      kwargs = kwargs.dup
      return kwargs unless kwargs.key?(:col_span)

      col_span = kwargs.delete(:col_span)

      css_class = if key
                    kwargs.dig(key, :class).to_s
      else
                    kwargs[:class]
      end

      css_class = ((css_class || "").split << "#{class_prefix}col-span-#{col_span}").join(" ")

      if key
        kwargs[key] ||= {}
        kwargs[key][:class] = css_class
      else
        kwargs[:class] = css_class
      end

      kwargs
    end

    # This helper can be used to define a default set of CSS classes but replace / remove some of them when needed.
    # The <tt>default_class</tt> argument defines the initial set of (default) classes.
    # The helper then recognizes two parameters in the keyword arguments:
    # * <tt>remove_default_class</tt> - class(es) in this parameter will be removed from the default set of classes
    # * <tt>class</tt> - class(es) in this parameter will be appended to the resulting set of classes
    # So, in essence, this helper does the following:
    #
    # <tt>class = default_class - remove_default_class + class</tt>
    #
    # For example, this link with normally defined (default) classes, which resides in a method:
    #
    #  def users_link
    #    link_to "Users", users_path, class: "font-bold text-lg"
    #  end
    # supports calling <tt>users_link</tt> and renders <tt>&lt;a class="font-bold text-lg" href="/users">Users&lt;/a></tt>.
    #
    # If we want to allow overriding some of the default classes, we can use this helper in the method:
    #
    #  def users_link(**kwargs)
    #    link_to "Users", users_path, **arguments_with_updated_default_class("font-bold text-lg", **kwargs)
    #  end
    #
    # Now, while the default call (<tt>users_link</tt>) renders the same default output, we can override the classes now
    # using <tt>users_link(remove_default_class: "text-lg", class: "text-sm")</tt>.
    # This renders <tt>&lt;a class="font-bold text-sm" href="/users">Users&lt;/a></tt> instead.
    #
    # The helper also supports prefixed class arguments which allow multiple class arguments to be removed / replaced.
    # E.g. with the following prefix paremeter set <tt>prefix: "form"</tt>, the helper will replace default classes,
    # expecting the <tt>remove_default_form_class</tt> and <tt>form_class</tt> parameters to be present to work with.
    def arguments_with_updated_default_class(default_class, prefix: nil, **kwargs)
      kwargs = kwargs.dup
      classes = default_class.to_s
      prefix = "#{prefix}_" if prefix

      remove_key = :"remove_default_#{prefix}class"
      class_key = :"#{prefix}class"

      if kwargs[remove_key].present?
        classes = (classes.split - kwargs[remove_key].split).join(" ")
        kwargs.delete(remove_key)
      end

      # simple_form sometimes uses array of classes instead of strings
      kwargs[class_key] = kwargs[class_key].map(&:to_s).join(" ") if kwargs[class_key].is_a?(Array)

      kwargs[class_key] = (classes.split + kwargs[class_key].to_s.split).join(" ")
      kwargs
    end

    def set_options; end
  end
end
