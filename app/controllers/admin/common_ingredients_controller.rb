class Admin::CommonIngredientsController < AdminController
  def index
    ingredients = Ingredient.common.includes(:category, :measurement).order(:name)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      ingredients = ingredients.where("LOWER(ingredients.name) LIKE ? OR LOWER(ingredient_categories.name) LIKE ?",
                                        query, query).references(:category)
    end

    @pagy, @common_ingredients = pagy(ingredients)
  end

  def new
    @common_ingredient = Ingredient.new
  end

  def create
    @common_ingredient = Ingredient.new(admin_common_ingredient_params.merge({ is_public: true, author: current_user }))

    if @common_ingredient.save
      redirect_to @common_ingredient, notice: "Common ingredient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @common_ingredient = Ingredient.common.find(params[:id])
    @common_ingredient.destroy!
    redirect_to admin_common_ingredients_url, notice: "Common ingredient was successfully destroyed.", status: :see_other
  end

  private

  def admin_common_ingredient_params
    params.require(:ingredient).permit(:name, :description, :category_id, :measurement_id)
  end
end
