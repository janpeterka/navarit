class RecipeCategoriesController < ApplicationController
  def multiselect_chips
    return unless params.include?(:combobox_values)

    combobox_values = params[:combobox_values].split(",").map(&:to_i)
    recipe_categories = RecipeCategory.order(:name).where(id: combobox_values)

    params[:for_id] = params[:target] if params[:target].present?

    render turbo_stream: helpers.hw_combobox_selection_chips_for(recipe_categories, display: :name, value: :id)
  end
end
