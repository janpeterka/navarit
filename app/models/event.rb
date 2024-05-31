# frozen_string_literal: true

class Event < ApplicationRecord
  broadcasts_refreshes

  include Publishable
  include Archivable
  include Event::HasPortionTypes
  include Event::Collaboration

  belongs_to :author, class_name: "User", foreign_key: "created_by"

  has_many :daily_plans, -> { order(date: :asc) }, dependent: :destroy
  has_many :event_portion_types, dependent: :destroy
  has_many :attendees, dependent: :destroy

  has_many :daily_plan_recipes, through: :daily_plans, source: :daily_plan_recipes
  has_many :recipes, through: :daily_plan_recipes

  alias_attribute :begins_at, :date_from
  alias_attribute :ends_at, :date_to

  validates :name, presence: true
  validates :date_from, presence: true
  validates :date_to, presence: true
  validate :date_to_after_date_from_validation
  validates :people_count, presence: true
  # validates :is_archived, presence: true
  # validates :is_shared, presence: true

  scope :future, -> { where("date_from >= ?", Date.today) }
  scope :past, -> { where("date_to < ?", Date.today) }
  scope :current, -> { where("date_from <= ? AND date_to >= ?", Date.today, Date.today) }

  after_create :create_daily_plans

  def update(params)
    update_date_from(params[:date_from].to_date) if params[:date_from].present?
    update_date_to(params[:date_to].to_date) if params[:date_to].present?

    # TODO: portion count, editing disabled for now
    # update_portion_count(params[:portion_count].to_i) if params[:portion_count].present?

    super(params)
  end

  def duration
    (date_to - date_from + 1).to_i
  end

  def destroyable?
    !published?
  end

  def duplicate_into(target_event) # rubocop:disable Metrics/AbcSize
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

    errors.add(:date_to, "must be after date from")
  end

  def create_daily_plans
    (date_from..date_to).each do |date|
      daily_plans << DailyPlan.new(date:, created_by: author.id)
    end

    self
  end

  def update_date_from(new_date_from)
    return if new_date_from == date_from

    if new_date_from > date_from
      daily_plans.before(new_date_from).destroy_all
    elsif new_date_from < date_from
      new_date_from.upto(date_from - 1.day) do |date|
        daily_plans.find_or_create_by(date:)
      end
    end
  end

  def update_date_to(new_date_to)
    return if new_date_to == date_to

    if new_date_to < date_to
      daily_plans.after(new_date_to).destroy_all
    elsif new_date_to > date_to
      date_to.upto(new_date_to) do |date|
        daily_plans.find_or_create_by(date:)
      end
    end
  end
end
