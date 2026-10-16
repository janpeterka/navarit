require "csv"

class Importers::IngredientsImporter
  def initialize(file_path:, initiator:)
    @initiator = initiator
    @file_path = file_path

    check_filetype

    @data = CSV.read(@file_path, headers: true)

    check_headers
  end

  def run
    @data.each do |row|
      import_row(row)
    end
  end

  def import_row(row)
    name = row["název"]
    measurement = Measurement.find_by(name: row["jednotka"])
    category = IngredientCategory.find_by(name: row["kategorie"])

    return if @initiator.ingredients.find_by(name:).present?
    return if Ingredient.common.find_by(name:).present?

    ingredient = Ingredient.new(name: row["název"], measurement:, category:, author: @initiator)
    ingredient.save!
  end

  private

  def check_filetype
    raise Exception, "Importer can only work with csv files for now" unless File.extname(@file_path) == ".csv"
  end

  def check_headers
    required_headers = [ "název", "jednotka", "kategorie" ]

    raise NameError, "Headers must include: #{required_headers.join(", ")}" unless (@data.headers & required_headers)  == required_headers
  end
end
