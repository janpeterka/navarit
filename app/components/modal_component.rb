class ModalComponent < ApplicationComponent
  attr_reader :header

  def initialize(header: nil, &)
    @header = header
  end
end
