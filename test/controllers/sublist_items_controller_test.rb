require 'test_helper'

class SublistItemsControllerTest < ActionController::TestCase
  setup do
    @sublist_item = sublist_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sublist_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sublist_item" do
    assert_difference('SublistItem.count') do
      post :create, sublist_item: { adress: @sublist_item.adress, description: @sublist_item.description, title: @sublist_item.title }
    end

    assert_redirected_to sublist_item_path(assigns(:sublist_item))
  end

  test "should show sublist_item" do
    get :show, id: @sublist_item.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sublist_item.id
    assert_response :success
  end

  test "should update sublist_item" do
    patch :update, id: @sublist_item, sublist_item: { adress: @sublist_item.adress, description: @sublist_item.description, title: @sublist_item.title }
    assert_redirected_to sublist_item_path(assigns(:sublist_item))
  end

  test "should destroy sublist_item" do
    assert_difference('SublistItem.count', -1) do
      delete :destroy, id: @sublist_item.id
    end

    assert_redirected_to sublist_items_path
  end
end
