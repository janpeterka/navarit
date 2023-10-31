# frozen_string_literal: true

module Tables
  # Helper class to store info about all columns in a table.
  # Normally, this class is used internally by `admin_table` (the Tables::TableComponent component).
  #
  # But it can also be used manually, e.g. when we need to render a single row of a table:
  #
  # column_definitions = Tables::TableColumns.new do |t|
  #   t.column :id
  #   ...
  # end
  # render Tables::RowComponent.new(record: @record, columns: column_definitions.columns)
  class TableColumns
    attr_reader :columns

    def initialize
      @columns = []

      yield(self) if block_given?
    end

    # Sets various properties for a given column, see TableColumnDefinition for more info.
    def column(...)
      @columns << Tables::TableColumnDefinition.new(...)

      nil # return nil so that we can use `= t.column`instead of `- t.column` in Slim templates
    end

    # Adds a right-aligned column suitable for action button(s)
    def action_column(method = nil, **options, &)
      options[:align] = options.fetch(:align, :right)
      column(method, **options, &)
    end
  end
end
