require 'test_helper'

class ListItemsControllerTest < ActionController::TestCase
  setup do
    @list_item = list_items(:one)
    @list = lists(:one)
    @user = users(:one)
    session[:user_id] = @user.id # Setting session[:user_id] instead of going through the sessioncontroller.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:list_items)
  end

  #test "should get new" do
  #  get :new
  #  assert_response :success
  #end

  test "should create list_item" do
    assert_difference('ListItem.count') do
      post :create, list_item: { adress: @list_item.adress, description: @list_item.description, title: @list_item.title, list_id: @list.id, sublist_id: '' }, format: :js # Had to add the format js to the post call.
      # make code for:
      # testing if AJAX renders new list item or it's errors.
      # Test animation
      # test Jquery removal of notices and error explanations.
      # test order of list items.
    end
    #assert_redirected_to list_path(@list)
    #assert_redirected_to list_item_path(assigns(:list_item))
  end

  test "should show list_item" do
    get :show, id: @list_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @list_item, list_id: @list_item.list_id
    assert_response :success
  end

  test "should update list_item" do
    patch :update, id: @list_item.id, list_item: { adress: @list_item.adress, description: @list_item.description, title: @list_item.title, list_id: @list.id, sublist_id: '' }
    assert_redirected_to list_item_path(assigns(:list_item))
  end

  test "should destroy list_item" do
    assert_difference('ListItem.count', -1) do
      delete :destroy, id: @list_item
    end

    assert_redirected_to list_items_path
  end
end
