require 'test_helper'
require 'capybara/rails'
#require 'spec_helper.rb'

class ActionDispatch::IntegrationTest # THIS IS PROBABLY NOT SUPPOSED TO BE HERE.
  include Capybara::DSL # Needed to run capybara

  def teardown
    Capybara.reset_sessions!
  end

  Capybara::Webkit.configure do |config|
    config.block_unknown_urls
  end

end

class UserFlowsTest < ActionDispatch::IntegrationTest

  setup do
    Capybara.current_driver = :webkit # Changed from .use_default_driver to Selenium driver that uses JS.

    #puts "THIS IS THE CURRENT DRIVER:"
    #puts Capybara.current_driver

    if @javascript
      puts "Doesn't support JavaScript"
    else
      puts 'Supports JavaScript'
    end
    #@list = List.create!(id: 1, title: 'Eriks list', description: 'MyText', user_id: 1)
  	@list = lists(:one)
  	@list_2 = lists(:two)
  	@list_item = list_items(:one)
    @user = users(:one)
    @sublist = lists(:three)
  end

  def login_user
    visit login_path
    fill_in("name", with: "erik")
    fill_in("password", with: "secret")
    click_on('Login')
    assert_equal lists_path, current_path
  end

  test "user should only see their own lists when logged in" do
    login_user
    visit lists_path
    assert has_content?('Eriks list')
  end

  # TESTING LISTS

  test "should create list" do # NOT TESTING IMAGE FILE OPTION
    login_user
    visit lists_path
    click_on('New List')

    fill_in("list_remote_list_image_url", with: "https://homepages.cae.wisc.edu/~ece533/images/cat.png")
    fill_in("list_title", with: "Eriks new list")
    fill_in("list_description", with: "This list was created during integration test!")
    click_on('Create')

    # assert_equal list_path(@list.id), current_path # NOT SURE HOW TO GET THE @USER.ID HERE????
    assert has_content?('Eriks new list')
    assert has_content?('This list was created during integration test!')
  end

  test "should show list" do
    login_user

    find(:xpath, "/html/body//a[contains(@href,'/lists/1')][contains(text(),'Eriks list')]").click
    assert_equal list_path(@list.id), current_path
    assert has_content?('Eriks list')
    assert has_content?('MyText')
  end

  test "should edit list" do # DID NOT TEST CHANGING IMAGE
    login_user
    find(:xpath, "/html/body//a[contains(@href,'/lists/1')][contains(text(),'Edit')]").click
    assert_equal edit_list_path(@list.id), current_path

    fill_in('list_title', with: 'Eriks list is now edited')
    fill_in('list_description', with: 'MyText is now edited!')
    click_on('Create')

    assert_equal list_path(@list.id), current_path
    assert has_content?('Eriks list is now edited')
    assert has_content?('MyText is now edited!')
  end


  test "should delete list" do
    login_user

    assert has_content?('Eriks list')
    find(:xpath, "/html/body//a[contains(@href,'/lists/1')][contains(text(),'Delete')]").click
    #page.accept_confirm { click_link "OK" } 
    #accept_alert(:alert)
    click_link('OK')

    #accept_modal
    #alert = page.driver.browser.switch_to.alert
    #alert.accept # Confirm deletion in popup
  #page.accept_confirm do
  #  click_button('OK')
  #end
    # page.accept_confirm { click_link "OK" } 
    assert_equal lists_path, current_path
    should have_no_content('Eriks list')
  end



end
