# frozen_string_literal: true

class Event < ApplicationRecord
  include Publishable
  include Archivable

  belongs_to :author, class_name: 'User', foreign_key: 'created_by'

  has_many :daily_plans, -> { order(date: :asc) }, dependent: :destroy
  has_many :event_portion_types, dependent: :destroy
  has_many :attendees, dependent: :destroy

  has_many :daily_plan_recipes, through: :daily_plans, source: :daily_plan_recipes
  has_many :recipes, through: :daily_plan_recipes

  validates :name, presence: true
  validates :date_from, presence: true
  validates :date_to, presence: true
  validate :date_to_after_date_from_validation
  validates :people_count, presence: true
  # validates :is_archived, presence: true
  # validates :is_shared, presence: true

  scope :future, -> { where('date_from >= ?', Date.today) }
  scope :past, -> { where('date_to < ?', Date.today) }
  scope :current, -> { where('date_from <= ? AND date_to >= ?', Date.today, Date.today) }

  after_create :create_daily_plans

  def duration
    (date_to - date_from + 1).to_i
  end

  def portion_count
    portion_count = 0
    accounted_for_count = 0
    event_portion_types.each do |ept|
      portion_count += ept.portion_type.size * ept.count
      accounted_for_count += ept.count
    end

    portion_count += (people_count - accounted_for_count) if people_count > accounted_for_count
    portion_count
  end

  def destroyable?
    !published?
  end

  def duplicate_into(target_event)
    daily_plans.each_with_index do |daily_plan, index|
      target_event.daily_plans[index].day_tasks = daily_plan.day_tasks.map(&:dup)

      daily_plan.daily_plan_recipes.each do |daily_plan_recipe|
        dpr = daily_plan_recipe.dup
        dpr.daily_plan = target_event.daily_plans[index]
        dpr.recipe = daily_plan_recipe.recipe
        target_event.daily_plans[index].daily_plan_recipes << dpr
      end
    end
  end

  def duplicate!
    event = duplicate
    event.save!
    event
  end

  def timetable
    @timetable ||= EventTimetable.new(self)
  end

  private

  def date_to_after_date_from_validation
    return unless date_to.present? && date_from.present? && date_to < date_from

    errors.add(:date_to, 'must be after date from')
  end

  def create_daily_plans
    (date_from..date_to).each do |date|
      daily_plans << DailyPlan.new(date:, created_by: author.id)
    end

    self
  end
end
