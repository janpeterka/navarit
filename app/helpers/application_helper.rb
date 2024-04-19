# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  include DateHelper

  def svg(name, options = {})
    default_classes = "inline me-2"
    classes = options[:class].present? ? "#{default_classes} #{options[:class]}" : default_classes

    file_path = Rails.root.join("app/assets/images/svg/#{name}.svg").to_s
    if File.exist?(file_path)
      svg_content = File.read(file_path).html_safe
      if svg_content.include?("class=")
        svg_content.sub!('<svg class="', "<svg class=\"#{classes} ")
      else
        svg_content.sub!("<svg", "<svg class=\"#{classes}\"")
      end
      svg_content.sub!("<svg", "<svg height=\"#{options[:height]}\"") if options[:height]
      svg_content.sub!("<svg", "<svg width=\"#{options[:height]}\"") if options[:height]
      return svg_content.html_safe
    end

    "(not found)"
  end
end
