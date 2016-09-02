require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  setup do
    @list = lists(:one)
    @list_2 = lists(:two)
    @user = users(:one)
    session[:user_id] = @user.id # Setting session[:user_id] instead of going through the sessioncontroller.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create list" do
    assert_difference('List.count') do
      post :create, list: { description: @list.description, title: @list.title, user_id: @user.id }
    end

    assert_redirected_to list_path(assigns(:list))
  end

  test "should show list" do
    get :show, id: @list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @list
    assert_response :success
  end

  test "should update list" do
    patch :update, id: @list, list: { description: @list.description, title: @list.title }
    assert_redirected_to list_path(assigns(:list))
  end

  test "should destroy list" do
    assert_difference('List.count', -1) do
      delete :destroy, id: @list.id
    end

    assert_redirected_to lists_path
  end

  test "should get index sublists belonging to only user" do
    get :index
    assert_response :success

    assigns[:lists].each do |list|
      user = List.find(list.id).user_id
      assert_equal user, @user.id
    end
  end

  test "should fail to show list because list belongs to another user" do
    get :show, id: @list_2
    assert_redirected_to lists_url
  end

  test "should fail to edit list because list belongs to another user" do
    get :edit, id: @list_2
    assert_redirected_to lists_url
  end

  test "should fail to update list because list belongs to another user" do
    patch :update, id: @list_2, list: { description: @list_2.description, title: @list_2.title }
    assert_redirected_to lists_url
  end

  test "should fail to destroy list because list belongs to another user" do
    assert_difference('List.count', 0) do
      delete :destroy, id: @list_2
    end

    assert_redirected_to lists_url
  end

end
