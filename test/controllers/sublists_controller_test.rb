require 'test_helper'

class SublistsControllerTest < ActionController::TestCase
  setup do
    @sublist = sublists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sublists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sublist" do
    assert_difference('Sublist.count') do
      post :create, sublist: { description: @sublist.description, title: @sublist.title }
    end

    assert_redirected_to sublist_path(assigns(:sublist))
  end

  test "should show sublist" do
    get :show, id: @sublist.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sublist.id
    assert_response :success
  end

  test "should update sublist" do
    patch :update, id: @sublist, sublist: { description: @sublist.description, title: @sublist.title }
    assert_redirected_to sublist_path(assigns(:sublist))
  end

  test "should destroy sublist" do
    assert_difference('Sublist.count', -1) do
      delete :destroy, id: @sublist.id
    end

    assert_redirected_to sublists_path
  end
end
