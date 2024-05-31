class PublishedRecipesController < PublicApplicationController
  def index
    load_recipes(params)
  end

  def show
    @recipe = Recipe.published.find(params[:id])

    redirect_to published_recipes_path if @recipe.blank?
    redirect_to @recipe if user_signed_in?

    @portion_count = if params[:portion_count].present?
      params[:portion_count].to_i
     else
      @recipe.portion_count
     end
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

  # private

  def load_recipes(params)
    @published_recipes = Recipe.published.includes(:category, :labels, :reactions, :ingredients, :author)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @published_recipes = @published_recipes.where("LOWER(recipes.name) LIKE ?", query)
    end

    if params[:category_ids].present?
      @published_recipes = @published_recipes.where(category_id: params[:category_ids].split(","))
    end

    if params[:difficulty_label_ids].present?
      labels = Label.where(id: params[:difficulty_label_ids].split(","))
      @published_recipes = @published_recipes.with_any_label(labels)
    end

    if params[:dietary_label_ids].present?
      labels = Label.where(id: params[:dietary_label_ids].split(","))
      diet_compliant_recipes = Recipe.joins(:recipe_labels).where(recipe_labels: { label_id: labels.map(&:id) }).group(:id).having("COUNT(DISTINCT recipe_labels.label_id) = ?", labels.size)
      @published_recipes = @published_recipes.where(id: diet_compliant_recipes.map(&:id))
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
    @published_recipes
  end
end
