# frozen_string_literal: true

class Recipe < ApplicationRecord
  include Publishable
  include Recipes::Likeable
  include Recipes::Prawnable

  belongs_to :category, class_name: 'RecipeCategory', optional: true
  belongs_to :author, class_name: 'User', foreign_key: 'created_by'

  has_many :recipe_labels, dependent: :destroy
  has_many :labels, through: :recipe_labels
  has_many :dietary_labels, -> { of_category('dietary') }, through: :recipe_labels, source: :label
  has_many :difficulty_labels, -> { of_category('difficulty') }, through: :recipe_labels, source: :label

  has_many :tasks, class_name: 'RecipeTask', dependent: :destroy

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  has_many :daily_plan_recipes
  has_many :daily_plans, through: :daily_plan_recipes

  has_many :events, through: :daily_plans

  validates :name, presence: true
  validates :portion_count, presence: true, numericality: { greater_than: 0 }

  scope :hidden, -> { where(is_hidden: true) }
  scope :visible, -> { where(is_hidden: false) }
  scope :used, -> { joins(:daily_plans).where('daily_plans.id IS NOT NULL').distinct.any? }
  scope :created_by, ->(user) { where(author: user) }
  # scope :draft, -> {joins(:ingredients).where.not("ingredients.id IS NULL").distinct.any? }

  def self.shopping
    Recipe.find(167)
  end

  def shopping?
    id == 167
  end

  def draft?
    ingredients.empty?
  end

  def used?
    events.any?
  end

  def deletable?
    return false if used?
    return false if published?

    true
  end

  def duplicate
    duplicate_recipe = dup
    duplicate_recipe.name = "#{name} (kopie)"
    duplicate_recipe.is_shared = false

    duplicate_recipe.tasks = tasks.map(&:dup)
    duplicate_recipe.recipe_labels = recipe_labels.map(&:dup)

    recipe_ingredients.each do |recipe_ingredient|
      duplicate_recipe_ingredient = recipe_ingredient.dup
      duplicate_recipe_ingredient.ingredient = recipe_ingredient.ingredient
      duplicate_recipe.recipe_ingredients << duplicate_recipe_ingredient
    end

    duplicate_recipe
  end
end
