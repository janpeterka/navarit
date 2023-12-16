# frozen_string_literal: true

class SearchboxComponent < ApplicationComponent
  attr_reader :path, :placeholder, :target_turbo_frame

  def initialize(path: nil, placeholder: nil, target_turbo_frame: nil)
    super
    @path = path
    @placeholder = placeholder
    @target_turbo_frame = target_turbo_frame
  end
end
