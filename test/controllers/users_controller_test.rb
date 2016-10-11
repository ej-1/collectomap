require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do 
    @user = users(:one)
    @user_2 = users(:two)
    session[:user_id] = @user.id # Setting session[:user_id] instead of going through the sessioncontroller.
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: 'Erik', password: @user.password_digest, password_confirmation: @user.password_digest} # Had to add the format js to the post call.
      #post :create, user: { name: @user.name, password_digest: @user.password_digest }
    end

    assert_redirected_to lists_path
    #assert_redirected_to users_path
    #assert_redirected_to user_path(assigns(:user))
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

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user.id, user: { password: @user.password_digest, password_confirmation: @user.password_digest }
    #assert_redirected_to users_path # does not seem like user is logged in when trying to update. Gets rerouted to login_path.
    assert_redirected_to user_path(assigns(:user))
    #patch :update, id: @user, user: { name: @user.name, password_digest: @user.password_digest }
    #assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  #test "should get index users belonging to only user" do
    #get :index
    #assert_redirected_to login_path
    #assert_response :success

    #assigns[:users].each do |user|
    #  assert_equal user, @user.id
    #end
  #end

  test "should fail to show user because it is not current user" do
    get :show, id: @user_2
    assert_redirected_to users_path
  end

  test "should fail to edit user because it is not current user" do
    get :edit, id: @user_2
    assert_redirected_to users_path
  end

  test "should fail to update user because it is not current user" do
    patch :update, id: @user_2, user: { name: @user_2.name, password: @user_2.password, password: @user_2.password_digest  }
    assert_redirected_to users_path
  end

  test "should fail to destroy user because it is not current user" do
    assert_difference('User.count', 0) do
      delete :destroy, id: @user_2
    end

    assert_redirected_to users_path
  end

end
