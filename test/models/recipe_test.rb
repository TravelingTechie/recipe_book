require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  def setup
    @user = users(:celeste)
    @recipe = @user.recipes.build(title: "Test Recipe",
    content:"Ingredient 1, Ingredient 2" ,
    category:"Cookies",
    user_id: @user.id)
  end

  test "should be valid" do
    assert @recipe.valid?
  end   
  
  test "user id should be present" do
    @recipe.user_id = nil
    assert_not @recipe.valid?
  end

  test "title should be at most 100 characters" do
    @recipe.title = "a" * 101
    assert_not @recipe.valid?
  end
  
  test "content should be present" do
    @recipe.content = " "
    assert_not @recipe.valid?
  end

  test "content should be at minimum 10 character and max 4000" do
    @recipe.content = "a" * 9
    assert_not @recipe.valid?
    @recipe.content = "a" * 4001
    assert_not @recipe.valid?
  end

  test "category should be present" do
    @recipe.category = " "
    assert_not @recipe.valid?
  end
end



