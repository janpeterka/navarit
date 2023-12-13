module PrawnHelper
  def table(data, document, same_size_columns: true)
    table_options = {}
    column_widths = []
    data.first.size.times do |_i|
      column_widths << document.bounds.width / data.first.size
    end
    table_options[:column_widths] = column_widths if same_size_columns
    # if same_size_columns

    table = Prawn::Table.new(data, document, cell_style: { borders: [], padding: 2 }, **table_options)
    document.start_new_page if document.cursor < table.height
    table.draw
  end
end
