require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_attributes = {
    name: "sam",
    password: "private",
    password_confirmation: "private"
    }
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @input_attributes
      #post :create, user: { name: @user.name, password_digest: @user.password_digest }
    end

    assert_redirected_to users_path
    #assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: @input_attributes
    assert_redirected_to users_path
    #patch :update, id: @user, user: { name: @user.name, password_digest: @user.password_digest }
    #assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
