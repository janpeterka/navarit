# frozen_string_literal: true

module Tables
  class TableComponent < ApplicationComponent
    attr_reader :records, :options, :pagy, :pagy_options, :column_definitions

    delegate :column, :action_column, :columns, to: :column_definitions

    def initialize(records:, **options)
      @records = records
      @options = options || {}
      @column_definitions = Tables::TableColumns.new

      @pagy = nil

      yield(self)
    end

    def pager(pagy, **options)
      @pagy = pagy
      @pagy_options = options

      nil
    end
  end
end
