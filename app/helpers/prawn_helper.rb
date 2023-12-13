# frozen_string_literal: true

module PrawnHelper
  def table(data, document:, same_size_columns: true, keep_together: true, table_options: {}) # rubocop:disable Metrics/AbcSize
    if same_size_columns && table_options[:column_widths].nil?
      table_options[:column_widths] = Array.new(data.first.size, document.bounds.width / data.first.size)
    end
    table_options[:cell_style] = { borders: [], padding: 2 }

    table = Prawn::Table.new(data, document, **table_options)

    document.start_new_page if keep_together && document.cursor < table.height

    table.draw
  end
end
