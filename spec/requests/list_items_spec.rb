require 'rails_helper'

RSpec.describe "ListItems", type: :request do
  describe "GET /list" do
    it "displays list items" do
      List.create(title: "Movies", description: "My favorite movies") # Create new list
      get lists_path
      expect(response).to have_http_status(200)
      response.body.should include("Movies") # Checks that the text from the list item title created is included on the view page rendered.
    end
  end

  describe "POST /list_items" do # One way of testing creating list items with Rspec.
    it "create list items 1" do
      ListItem.create(title: "Die Hard", description: "Awesome movie with Bruce Willis!", list_id: "1")
      get list_items_path
      response.body.should include("Die Hard") # Checks that the text from the list item title created is included on the view page rendered.
    end
  end

  describe "POST /list_items" do # Another way to test creating list items with Rspec.
    it "create list items 2" do
      post_via_redirect list_items_path(:list_item => {:title => "Die Hard", :description => "Awesome movie with Bruce Willis!", :list_id => "1"}, format: :js)
      # Have to include js format in request to work.
      response.body.should include("Die Hard")
      response.body.should include("Awesome movie with Bruce Willis!")
    end
  end

  describe "GET /lists", :js => true do # This uses Capybara to better mimic user behaviour. in previous examples requests went direclty through the request
    #path and not through through the create new list item form.
    it "visit lists and create list item" do
      List.create(title: "Movies", description: "My favorite movies") # Had to create list here. Otherwise click_link does not work.
      visit lists_path
      click_on('Movies')

      fill_in "list_item_title", :with => "The terminator"
      fill_in "list_item_description", :with => "The terminator"
      click_on "Post"
      page.should have_content("List item was successfully created.")
      #save_and_open_page # Uses Launchy gem to open the web browers and show you the form

    end
  end

end