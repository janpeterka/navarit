require "test_helper"

class Importers::IngredientsImporterTest < ActiveSupport::TestCase
  test "raises error on non-csv file" do
    exception = assert_raises Exception do
      Importers::IngredientsImporter.new(file_path: "test/data/importers/ingredients.xlsx", initiator: @current_user).run
    end

    assert_equal exception.message, "Importer can only work with csv files for now"
  end

  test "raises error if data headers are not correct" do
    exception = assert_raises NameError do
      Importers::IngredientsImporter.new(file_path: "test/data/importers/ingredients_with_wrong_headers.csv", initiator: @current_user).run
    end

    assert_equal exception.message, "Headers must include: název, jednotka, kategorie"
  end

  test "creates ingredients with correct name" do
    # TODO: prepare data in database (categories, measurements, common ingredients)

    Importers::IngredientsImporter.new(file_path: "test/data/importers/ingredients.csv", initiator: @current_user).run

    assert_equal Ingredient.all.count, 10
  end

  test "it doesn't create duplicate ingredients" do
    Ingredient.create(name: "Mrkev", author: @current_user)

    Importers::IngredientsImporter.new(file_path: "test/data/importers/ingredients.csv", initiator: @current_user).run

    assert_equal Ingredient.all.count, 10
  end

  test "it assigns correct category and measurement" do
    Measurement.create(name: "gram")
    IngredientCategory.create(name: "Zelenina")

    Importers::IngredientsImporter.new(file_path: "test/data/importers/ingredients.csv", initiator: @current_user).run

    assert Ingredient.find_by(name: "Mrkev").category.name == "Zelenina"
  end
end
