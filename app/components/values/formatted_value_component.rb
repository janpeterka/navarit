# frozen_string_literal: true

module Values
  class FormattedValueComponent < ApplicationComponent
    def initialize(value:, format: nil)
      @value = value
      @format = format || format_for_value_type(value)
    end

    def call
      normalize_format_options
      formatted_value(@value)
    end

    private

    def normalize_format_options
      return if @format.is_a?(Hash)

      @format = {
        type: @format
      }
    end

    def formatted_value(value)
      case @format[:type]
      when :id
        "##{value}"
      when :date_time
        value&.to_formatted_s(:app_datetime)
      when :date
        value&.to_formatted_s(:app_date)
      when :number
        number_with_delimiter(value, delimiter: " ")
      when :currency
        helpers.currency_amount(value)
      when :truncated_text
        render Values::TruncatedTextComponent.new(value:, **@format.except(:type))
      when nil
        value
      else
        raise ArgumentError, "Invalid format #{@format[:type]}"
      end
    end

    def format_for_value_type(value)
      case value
      when ::Time, ::DateTime, ActiveSupport::TimeWithZone
        :date_time
      when ::Date
        :date
      end
    end
  end
end
