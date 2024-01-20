class RecipesController < ApplicationController
  def categories
    @categories = parse_yaml("#{Rails.root.to_s}/static_data/categories.yml")
  end
end
