class DailyPlanTask < ApplicationRecord
  belongs_to :daily_plan

  validates :name, presence: true
end
