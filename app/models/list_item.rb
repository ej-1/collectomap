require 'my_custom_methods'

class ListItem < ActiveRecord::Base
  include MyCustomMethods
	belongs_to :lists
	validates :title, :description ,presence: true # adress is optional
	validate :check_image_url # Check that url for image is valid. My custom method.
	validates :description, :uniqueness => {:scope => [:title, :description]} # Add user id to check it unique to user.
  validate :check_image_url # Check that url for image is valid. My custom method.
	mount_uploader :image, ImageUploader
end

