require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

	test "should login" do
		erik = users(:one)
		post :create, name: erik.name, password: 'secret'
		assert_redirected_to admin_url
		assert_equal erik.id, session[:user_id]
	end

	test "should fail login" do
		erik = users(:one)
		post :create, name: erik.name, password: 'wrong'
		assert_redirected_to login_url
	end

	test "should logout" do
		delete :destroy
		assert_redirected_to store_url
	end

end
