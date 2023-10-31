module ApplicationHelper
  def svg(name, options = {})
    default_classes = 'inline me-2'
    classes = options[:class].present? ? "#{default_classes} #{options[:class]}" : default_classes

    file_path = "#{Rails.root.join("app/assets/images/svg/#{name}.svg")}"
    if File.exist?(file_path)
      svg_content = File.read(file_path).html_safe
      svg_content.sub!('<svg', "<svg class=\"#{classes}\"")
      svg_content.sub!('<svg', "<svg height=\"#{options[:height]}\"") if options[:height]
      svg_content.sub!('<svg', "<svg width=\"#{options[:height]}\"") if options[:height]
      return svg_content.html_safe
    end

    '(not found)'
  end
end
