require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    erik = users(:one)
    post :create, name: erik.name, password: 'secret'
    assert_redirected_to lists_url
    assert_equal erik.id, session[:user_id]
  end

  test "should fail login" do
    erik = users(:one)
    post :create, name: erik.name, password: 'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to login_url
  end

end
