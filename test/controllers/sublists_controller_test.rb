require 'test_helper'

class SublistsControllerTest < ActionController::TestCase
  setup do
    @sublist = sublists(:one)
    @sublist_2 = sublists(:three)
    @list = lists(:one)
    @user = users(:one)
    @admin = users(:admin)
    session[:user_id] = @user.id # Setting session[:user_id] instead of going through the sessioncontroller.
  end

  test "should get index" do
    get :index
    assert_redirected_to landing_path
    #assert_response :success
    #assert_not_nil assigns(:sublists)
  end

  test "should get new" do
    xhr :get, :new, list: @list.id, format: :js # changed to xhr :get in order to get by invalid cross origin request error.
      #http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#csrf-protection-from-remote-script-tags
      #http://stackoverflow.com/questions/23901978/invalid-cross-origin-request-after-upgrading-to-rails-4-1
    assert_response :success
  end

  test "should create sublist" do
    assert_difference('Sublist.count') do
      post :create, sublist: { description: @sublist.description, title: @sublist.title, list_id: @list.id }, format: :js # Had to add the format js to the post call.
    end

    #assert_redirected_to sublist_path(assigns(:sublist))
  end

  test "should show sublist" do
    get :show, id: @sublist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sublist
    assert_response :success
  end

  test "should update sublist" do
    patch :update, id: @sublist, sublist: { description: @sublist.description, title: @sublist.title }
    assert_redirected_to sublist_path(assigns(:sublist))
  end

  test "should destroy sublist" do
    assert_difference('Sublist.count', -1) do
      delete :destroy, id: @sublist
    end

    assert_redirected_to sublists_path
  end

  test "should not get index sublists belonging to only user" do
    get :index
    assert_redirected_to landing_path
    #assert_response :success

    #list = assigns[:sublists].first.list_id # :sublists is the same as @index which is declared to index method in sublists_controller.
    #user = List.find(list).user_id

    #assigns[:sublists].each do |sublist|
    #  list = sublist.list_id
    #  user = List.find(list).user_id
    #  assert_equal user, @user.id
    #end
  end

  test "should fail to show sublist because sublist belongs to another user" do
    get :show, id: @sublist_2
    assert_redirected_to lists_url
  end

  test "should fail to edit sublist because sublist belongs to another user" do
    get :edit, id: @sublist_2
    assert_redirected_to lists_url
  end

  test "should fail to update sublist because sublist belongs to another user" do
    patch :update, id: @sublist_2, sublist: { description: @sublist_2.description, title: @sublist_2.title }
    assert_redirected_to lists_url
  end

  test "should fail to destroy sublist because sublist belongs to another user" do
    assert_difference('Sublist.count', 0) do
      delete :destroy, id: @sublist_2
    end

    assert_redirected_to lists_url
  end

  test "should get index sublists for admin" do
    session[:user_id] = @admin.id
    get :index
    assert_response :success

    assigns[:sublists].each do |sublist|
      list = Sublist.find(sublist.id).list_id
      user = List.find(list).user_id
      assert_not_equal user, @admin.id # Assuming admin has not created any sublists, then all sublists user_ids will be different from admins user_id.
    end
  end

  test "should show sublist for admin" do
    session[:user_id] = @admin.id
    get :show, id: @sublist_2
    assert_response :success
  end

  test "should get edit sublist for admin" do
    session[:user_id] = @admin.id
    get :edit, id: @sublist_2
    assert_response :success
  end

  test "should update sublist for admin" do
    session[:user_id] = @admin.id
    patch :update, id: @sublist_2, sublist: { description: @sublist_2.description, title: @sublist_2.title }
    assert_redirected_to sublist_path(assigns(:sublist))
  end

  test "should destroy sublist for admin" do
    session[:user_id] = @admin.id
    assert_difference('Sublist.count', -1) do
      delete :destroy, id: @sublist_2.id
    end

    assert_redirected_to sublists_path
  end

end
