require 'test_helper'

class SublistsControllerTest < ActionController::TestCase
  setup do
    @sublist = sublists(:one)
    @list = lists(:one)
    @user = users(:one)
    session[:user_id] = @user.id # Setting session[:user_id] instead of going through the sessioncontroller.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sublists)
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
end
