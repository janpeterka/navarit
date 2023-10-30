class DailyPlanTask < ActiveRecord
  belongs_to :daily_plan

  validates :name, presence: true
end
