# frozen_string_literal: true

class IngredientsController < ApplicationController
  load_and_authorize_resource

  def index
    @ingredients = current_user.ingredients.includes(:category, :measurement).order(:name)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @ingredients = @ingredients.where("LOWER(ingredients.name) LIKE ? OR LOWER(ingredient_categories.name) LIKE ?",
                                        query, query).references(:category)
    end

    @pagy, @ingredients = pagy(@ingredients)
  end

  def show; end

  def new
    @ingredient = Ingredient.new
  end

  def edit; end

  def create
    @ingredient = current_user.ingredients.new(ingredient_params)

    if @ingredient.save
      if params[:ingredient][:recipe_id].present?
        # Ad hoc adding of ingredient
        redirect_to recipe_url(Recipe.find(params[:ingredient][:recipe_id]), edited_section: :ingredients, preselected_ingredient_id: @ingredient.id)
      else
        redirect_to ingredient_url(@ingredient)
      end

    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_url(@ingredient), notice: "surovina byla upravena"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy!

    redirect_to ingredients_url, notice: "Ingredient was successfully destroyed."
  end

  private

    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def ingredient_params
      params.require(:ingredient).permit(:name, :description, :category_id, :measurement_id)
    end
end
