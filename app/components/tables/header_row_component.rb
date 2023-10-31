# frozen_string_literal: true

module Tables
  class HeaderRowComponent < ApplicationComponent
    attr_reader :columns

    def initialize(columns:)
      @columns = columns
    end
  end
end
