# frozen_string_literal: true

module PrawnHelper
  def shrimpy_document(title: nil)
    # Sensible defaults for Prawn::Document
    document = Prawn::Document.new(margin: 30, page_size: "A4", page_layout: :portrait)

    document.font_families.update("DejaVu" => {
                                    normal: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans.ttf",
                                    bold: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans-Bold.ttf",
                                    italic: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans-Oblique.ttf",
                                    bold_italic: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans-BoldOblique.ttf"
                                  })

    document.font "DejaVu"

    return document unless title.present?

    document.text title, size: 20, style: :bold, align: :center
    document.move_down 10

    document
  end

  def shrimpy_table(data, document:, same_size_columns: true, keep_together: true, table_options: {}) # rubocop:disable Metrics/AbcSize
    if same_size_columns && table_options[:column_widths].nil?
      table_options[:column_widths] = Array.new(data.first.size, document.bounds.width / data.first.size)
    end
    table_options[:cell_style] = { borders: [], padding: 2 }

    table = Prawn::Table.new(data, document, **table_options)

    document.start_new_page if keep_together && document.cursor < table.height

    table.draw
  end
end
