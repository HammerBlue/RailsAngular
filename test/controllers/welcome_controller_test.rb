require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should render the index view without a user" do
  	get :index
    assert_template layout: "layouts/angular"
  	assert_response :success
  end

end
