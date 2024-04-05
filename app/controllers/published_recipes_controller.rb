# frozen_string_literal: true

class PublishedRecipesController < PublicApplicationController
  def index
    # @published_recipes = Recipe.published.includes(:category, :labels, :reactions)
    @published_recipes = Recipe.published.includes(:category, :labels, :reactions)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @published_recipes = @published_recipes.where("LOWER(recipes.name) LIKE ? OR LOWER(recipe_categories.name) LIKE ? OR LOWER(labels.visible_name) LIKE ?",
                                                    query, query, query).references(:category, :labels, :reactions)
    end

    @published_recipes = @published_recipes.where(category_id: params[:category_id]) if params[:category_id].present?

    if params[:dietary_label_id].present?
      @published_recipes = @published_recipes.joins(:labels).where(labels: Label.find(params[:dietary_label_id]))
    end

    case params[:sorting]&.to_sym
    when :favorite
      # TODO: this will make trouble with pagination, probably will need to be solved by adding counter cache to reactions
      @published_recipes = @published_recipes.sort_by { _1.reactions.count }.reverse
    when :alphabetically
      @published_recipes = @published_recipes.order(:name)
    when :newest
      @published_recipes = @published_recipes.order(created_at: :desc)
    when :oldest
      @published_recipes = @published_recipes.order(:created_at)
    else
      @published_recipes = @published_recipes.sort_by { _1.reactions.count }.reverse
    end

    # @pagy, @recipes = pagy(@recipes)
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    authorize! :publish, recipe

    if recipe.publish!
      flash[:notice] = "recept byl zveřejněn"
    else
      flash[:error] = "recept nebyl zveřejněn"
    end

    redirect_back_or_to recipe
  end

  def destroy
    recipe = Recipe.find(params[:id])
    authorize! :publish, recipe

    recipe.unpublish!

    redirect_back_or_to recipe, notice: "recept byl zneveřejněn"
  end
end
