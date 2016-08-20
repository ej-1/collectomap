require 'rails_helper'

RSpec.describe "ListItems", type: :request do
  describe "GET /list" do
    it "displays list items" do
      List.create(title: "Movies", description: "My favorite movies") # Create new list item
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

  describe "POST /list_items" do # With this method we go through the list_items_path and does not mimic how the user would behave.
    it "create list item" do
      post_via_redirect list_items_path, :list_item => {title: "Rower", description: "Awesome movie with Bruce Willis!", list_id: "1"}
      response.body.should include("Rower") # Checks that the text from the list item title created is included on the view page rendered.
    end
  end

end