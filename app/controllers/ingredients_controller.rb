class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show edit update destroy]

  # GET /ingredients or /ingredients.json
  def index
    @ingredients = Current.user.ingredients
  end

  # GET /ingredients/1 or /ingredients/1.json
  def show; end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit; end

  # POST /ingredients or /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to ingredient_url(@ingredient), notice: 'Ingredient was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ingredients/1 or /ingredients/1.json
  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_url(@ingredient), notice: 'Ingredient was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /ingredients/1 or /ingredients/1.json
  def destroy
    @ingredient.destroy!

    redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ingredient_params
    params.require(:ingredient).permit(:name, :category_id, :measurement_id)
  end
end
