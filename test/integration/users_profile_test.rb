require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:celeste)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.recipes.count.to_s, response.body
    @user.recipes.each do |recipe|
      assert_match recipe.content, response.body 
    end
  end

end
