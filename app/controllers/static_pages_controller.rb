class StaticPagesController < ApplicationController
  def home
    @recipe = current_user.recipes.build if logged_in?
  end

  def help
  end
  
  def about
  end

  def contact
  end

end
