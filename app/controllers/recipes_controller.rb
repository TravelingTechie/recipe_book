class RecipesController < ApplicationController
  before_action :logged_in_user, only: [:create,:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def new
    # if user has 5 or more recipes, I want to redirect to home with a flash message
    if current_user.recipes.count > 4
      flash[:success] = "You have reached the max number of recipes allowed:  #{number_recipes}" 
      redirect_to root_url
      
      else
        @recipe = Recipe.new
        categories
      end 

  end

  def categories    
    @categories = Rails.cache.fetch('categories', expires_in: 1.day) do
      parse_yaml("#{Rails.root}/app/static_data/categories.yml")
    end
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe created!"
      redirect_to root_url
    else
      render 'static_pages/home', status: :unprocessable_entity
    end
  end 

  def edit
    categories
  end

  def update
    if @recipe.update(recipe_params)
      # Handle a successful update.
      flash[:success] = "Recipe updated"
      redirect_to root_url
    else
      render 'edit', status: :unprocessable_entity
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
    categories
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deleted"
  
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :content, :category)
  end

  def correct_user
    @recipe = current_user.recipes.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @recipe.nil?
  end

  def number_recipes
    @recipe_count = current_user.recipes.count
  end
end
