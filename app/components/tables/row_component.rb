# frozen_string_literal: true

module Tables
  class RowComponent < ApplicationComponent
    attr_reader :record, :columns

    def initialize(record:, columns:)
      @record = record
      @columns = columns
    end
  end
end
