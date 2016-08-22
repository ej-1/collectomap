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

  describe "GET /list_items" do
    it "displays list items" do
    	ListItem.create(title: "Die Hard", description: "Awesome movie with Bruce Willis!", list_id: "1") # Create new list item
      get list_items_path
      expect(response).to have_http_status(200)
      response.body.should include("Die Hard") # Checks that the text from the list item title created is included on the view page rendered.
    end
  end



  describe "GET /lists" do # This uses Capybara to better mimic user behaviour.
    it "create list item" do
      List.create(title: "Movies", description: "My favorite movies") # Had to create list here. Otherwise click_link does not work.
      visit lists_path
      click_on('Movies')

      fill_in "list_item_title", :with => "The terminator"
      fill_in "list_item_description", :with => "The terminator"
      click_on "Post"

      #page.should have_content("List item was successfully created.")
      save_and_open_page
    end
  end

  describe "GET /list_items" do # This uses Capybara to better mimic user behaviour.
    it "create list item" do
      visit list_items_path
      #fill_in "new_list_item", :with => "The terminator"
      #fill_in "new_list_item", with: 'foo bar'
      #fill_in "Description", :with => "Cult movie about a robot."
      #first(:link, "Edit").click

      #click_link "Edit"
      #page.should have_content("List item was successfully created.")
      #save_and_open_page
    end
  end

  describe "GET /list_items" do
    it "supports js" do
      visit list_items_path
      click_link 'test js'
    end
  end

end