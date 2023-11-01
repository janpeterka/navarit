# frozen_string_literal: true

module Tables
  # Helper class storing various info about a table column definition.
  class TableColumnDefinition
    attr_reader :method, :header, :title, :css_class, :header_class, :block

    # Sets various properties for a table column:
    # @param method This method will be called on the record to retrieve data and its name will be used for header.
    # If you provide a column block, the method parameter can be anything and will become the header
    # (or use the header parameter).
    # @param header Use custom header in the table header. By default it will be a humanized version of the `method`.
    # @param title Add title for header.
    # @param link_to_detail Use true to automatically link the value to the detail page.
    # @param align Use :right to align the data to the right side (the default align is to the left).
    # @param format Specify the format for the value (see Values::FormattedValueComponent).
    # @param class Append a custom class to the default CSS classes of the table cells.
    # @param block Use a custom block to get the value. The block will be yielded with the record as the parameter.
    def initialize(method = nil, header: nil, title: nil, link_to_detail: false, format: nil, **options, &block)
      if method.nil? && block.nil?
        raise ArgumentError, 'You must provide either the `method` parameter or a block, or both.'
      end

      @method = method
      @header = header
      @title = title
      @link_to_detail = link_to_detail
      @format = format
      @css_class, @header_class = apply_classes_for_options(**options)
      @block = block

      @format ||= :id if @method.to_s == 'id' && !@block
    end

    # Returns the proper instantiated component for this column and record value.
    def value_for(record, view_context:)
      raw_value = raw_value_for(record, view_context:)
      Values::FormattedValueComponent.new(value: raw_value, format: @format)
    end

    def link_to_detail?
      @link_to_detail
    end

    private

    def raw_value_for(record, view_context:)
      if block
        view_context.capture { block.call(record).presence }
      else
        record.public_send(method).presence
      end
    end

    def apply_classes_for_options(**options)
      value_class = options[:class] || ''
      header_class = options[:header_class] || ''

      if options[:align] == :right
        value_class << ' text-right'
        header_class << ' text-right'
      end

      [value_class, header_class]
    end
  end
end
