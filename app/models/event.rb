# frozen_string_literal: true

class Event < ApplicationRecord
  include Publishable
  include Archivable

  has_many :daily_plans, dependent: :destroy
  has_many :event_portion_types, dependent: :destroy
  has_many :attendees, dependent: :destroy

  has_many :day_recipes, through: :daily_plans
  has_many :recipes, through: :day_recipes

  validates :name, presence: true
  validates :date_from, presence: true
  validates :date_to, presence: true
  validate :date_to_after_date_from_validation
  validates :people_count, presence: true
  # validates :is_archived, presence: true
  # validates :is_shared, presence: true

  scope :active, -> { where(is_archived: false) }
  scope :archived, -> { where(is_archived: true) }
  scope :published, -> { where(is_shared: true) }
  scope :future, -> { where('date_from >= ?', Date.today) }
  scope :past, -> { where('date_to < ?', Date.today) }
  scope :current, -> { where('date_from <= ? AND date_to >= ?', Date.today, Date.today) }

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

  private

  def date_to_after_date_from_validation
    return unless date_to.present? && date_from.present? && date_to < date_from

    errors.add(:date_to, 'must be after date from')
  end
end
