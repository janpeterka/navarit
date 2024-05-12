# frozen_string_literal: true

class LabelBadgeComponentPreview < ViewComponent::Preview
  def default
    render(Badges::LabelBadgeComponent.new(label: Label.first))
  end
end
