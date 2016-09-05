require 'test_helper'

class ListItemsControllerTest < ActionController::TestCase
  setup do
    @list_item = list_items(:one)
    @list_item_2 = list_items(:two)
    @list = lists(:one)
    @user = users(:one)
    @admin = users(:admin)
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
      post :create, list_item: { adress: @list_item.adress, description: @list_item.description, title: @list_item.title, list_id: @list.id, sublist_id: '', image: @list_item.image }, format: :js # Had to add the format js to the post call.
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






  test "should get index list_item belonging to only user" do
    get :index
    assert_response :success

    assigns[:list_items].each do |list_item|
      user = List.find(list_item.list_id).user_id
      assert_equal user, @user.id
    end
  end

  test "should fail to edit list_item because list_item belongs to another user" do
    get :edit, id: @list_item_2
    assert_redirected_to lists_url
  end

  test "should fail to update list_item because list_item belongs to another user" do
    patch :update, id: @list_item_2, list_item: { description: @list_item_2.description, title: @list_item_2.title }
    assert_redirected_to lists_url
  end

  test "should fail to destroy list_item because list_item belongs to another user" do
    assert_difference('ListItem.count', 0) do
      delete :destroy, id: @list_item_2
    end

    assert_redirected_to lists_url
  end





  test "should get index list_item for admin" do
    session[:user_id] = @admin.id
    get :index
    assert_response :success

    assigns[:list_items].each do |list_item|
      list = ListItem.find(list_item.id).list_id
      user = List.find(list).user_id
      assert_not_equal user, @admin.id # Assuming admin has not created any sublists, then all sublists user_ids will be different from admins user_id.
    end
  end

  test "should show list item for admin" do
    session[:user_id] = @admin.id
    get :show, id: @list_item_2
    assert_response :success
  end

  test "should get edit list item for admin" do
    session[:user_id] = @admin.id
    get :edit, id: @list_item_2
    assert_response :success
  end

  test "should update list item for admin" do
    session[:user_id] = @admin.id
    patch :update, id: @list_item_2, list_item: { description: @list_item_2.description, title: @list_item_2.title }
    assert_redirected_to list_item_path(assigns(:list_item))
  end

  test "should destroy list item for admin" do
    session[:user_id] = @admin.id
    assert_difference('ListItem.count', -1) do
      delete :destroy, id: @list_item_2.id
    end

    assert_redirected_to list_items_path
  end

end
