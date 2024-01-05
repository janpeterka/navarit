# frozen_string_literal: true

module ApplicationComponentsHelper
  def menu(**kwargs, &)
    kwargs[:current_path] ||= request.path
    render MenuComponent.new(**kwargs), &
  end

  def button_link_to(name, path, **, &)
    render Buttons::ButtonLinkComponent.new(name:, path:, **), &
  end

  def action_button_to(name, path, **, &)
    render Buttons::ButtonToComponent.new(name:, path:, **), &
  end

  def table(records, **, &)
    render Tables::TableComponent.new(records:, **, &)
  end

  def form_field(**, &)
    render FormFields::InputFieldComponent.new(**), &
  end

  def label_badge(label, **, &)
    render Badges::LabelBadgeComponent.new(label:, **), &
  end

  def searchbox(placeholder:, path:, target_turbo_frame: nil, **, &)
    render SearchboxComponent.new(placeholder:, path:, target_turbo_frame:), &
  end

  def heading(content, level = :h2, **kwargs)
    default_classes = { h2: 'text-xl font-bold mb-2', h3: 'font-bold mb-2' }
    classes = "#{default_classes[level]} #{kwargs[:class]}"

    "<#{level} class='#{classes}'>#{content}</#{level}>".html_safe
  end

  # def admin_detail(record, **kwargs, &)
  #   render Details::DetailComponent.new(record:, **kwargs), &
  # end

  # def admin_dropdown_menu(**kwargs, &)
  #   render Menus::DropdownMenuComponent.new(**kwargs), &
  # end

  # def level4_admin_menu(**kwargs, &)
  #   kwargs[:current_path] ||= request.path
  #   render Menus::Level4MenuComponent.new(**kwargs), &
  # end

  # def admin_link_to(name, path, **kwargs, &)
  #   render Links::LinkToComponent.new(name:, path:, **kwargs), &
  # end

  # def admin_button_link_to(name, path, **kwargs, &)
  #   render Buttons::ButtonLinkComponent.new(name:, path:, **kwargs), &
  # end

  # def admin_button_to(name, path, **kwargs, &)
  #   render Buttons::ButtonToComponent.new(name:, path:, **kwargs), &
  # end

  # def admin_button_back(name, path, **kwargs)
  #   render Buttons::ButtonBackComponent.new(name:, path:, **kwargs)
  # end

  # def admin_card(**kwargs, &)
  #   render Containers::CardComponent.new(**kwargs), &
  # end

  # def admin_heading(**kwargs, &)
  #   show_admin_help = kwargs.key?(:show_admin_help) ? kwargs.delete(:show_admin_help) : kwargs[:h1]
  #   kwargs[:admin_help] = @admin_help if show_admin_help

  #   render Containers::HeadingComponent.new(**kwargs), &
  # end

  # def admin_badge(value, **kwargs, &)
  #   render Badges::BadgeComponent.new(value:, **kwargs), &
  # end
  # This helper can be used to define a default set of CSS classes but replace / remove some of them when needed.
  # The <tt>default_class</tt> argument defines the initial set of (default) classes.
  # The helper then recognizes two parameter in the keyword arguments:
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
  # expecting the <tt>replace_default_form_class</tt> and <tt>form_class</tt> parameters to be present to work with.
  def arguments_with_updated_default_class(default_class, prefix: nil, **kwargs)
    kwargs = kwargs.dup
    classes = default_class.to_s
    prefix = "#{prefix}_" if prefix

    remove_key = :"remove_default_#{prefix}class"
    class_key = :"#{prefix}class"

    if kwargs[remove_key].present?
      classes = (classes.split - kwargs[remove_key].split).join(' ')
      kwargs.delete(remove_key)
    end

    # simple_form sometimes uses array of classes instead of strings
    kwargs[class_key] = kwargs[class_key].map(&:to_s).join(' ') if kwargs[class_key].is_a?(Array)

    kwargs[class_key] = (classes.split + kwargs[class_key].to_s.split).join(' ')
    kwargs
  end
end
