require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @recipe = recipes(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { title: "Test Recipe",
                                  content:"Ingredient 1, Ingredient 2" ,
                                  category:"Cookies" } }
    end
    assert_redirected_to login_url
  end


  test "should redirect destroy when not logged in" do
    assert_no_difference 'Recipe.count' do
      delete recipe_path(@recipe)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end
end
