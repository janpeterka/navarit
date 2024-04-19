# frozen_string_literal: true

module DateHelper
  def weekday_name(date)
    I18n.t("date.day_names")[date.wday]
  end

  def formatted_date(date)
    date.strftime("%-d.%m.%Y")
  end
end
