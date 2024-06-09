class CommonIngredientsController < ApplicationController
  def show
    @ingredient = Ingredient.common.find(params[:id])
  end
end
