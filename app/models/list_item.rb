require 'my_custom_methods'

class ListItem < ActiveRecord::Base
  include MyCustomMethods
  include ActionView::Helpers::TextHelper # Needed for truncate method
	belongs_to :lists
  validates :title, :description, :list_id, presence: true # adress is optional
	validate :check_image_url # Check that url for image is valid. My custom method.
	validates :description, :uniqueness => {:scope => [:title, :description]} # Add user id to check it unique to user.
  validate :check_image_url # Check that url for image is valid. My custom method.
	mount_uploader :image, ImageUploader

  def self.set_marker(object)
  	include ActionView::Helpers::TextHelper # Needed for truncate method
  	# Created a workaround method. To determine if there is one record or many records in the variable. Could not find method to do this.
  	# It is necessary to know if there is one or several methods to get one @marker or many @markers.
  	@size = object.inspect.scan(/(?=title)/).count # .inspect turns variable into string the rest looks for title and counts how many times it occurs.
	  if @size == 1 # If there is one list item record.
      unless object.adress == "" # Used this way of detecting if empty. nil? does not work. .first does not allow nil.
        @list_item_adress = object.adress.scan(/\(([^\)]+)\)/).last.first # Get adress as text without coordinates.
                                                                              # http://stackoverflow.com/questions/11000724/in-ruby-get-content-in-brackets
      end
      adress = object.adress.split(",")
      @marker = # Create hash of marker coordinates for list items.
        [{
           lat: adress[0],
           lng: adress[1],
           title: object.title,
           desc: object.truncate(object.description, length: 300),
           id: object.id
         }]

	  elsif @size > 1 # If there are many list item records.
      @markers = object.map do |list_item| # Create hash of marker coordinates for list items.
        adress = list_item.adress.split(",")
         {
           lat: adress[0],
           lng: adress[1],
           title: list_item.title,
           desc: list_item.truncate(list_item.description, length: 300),
           id: list_item.id
         }
    	end

	  else # If there are no list item records.
	  end
  end

end
