require 'my_custom_methods'

class User < ActiveRecord::Base
  include MyCustomMethods
  has_many :lists, -> { where(parent_id: nil) }, dependent: :destroy
  has_many :sublists, foreign_key: "parent_id", class_name: "List" # Declare explicitily name of Model with class_name, since a sublist model does not exist.
  
  validates :name, presence: true, uniqueness: true # Validates user name does has been submitted and does not already exist when creatin new user.
  has_secure_password # Rails - Forces the user to type the password again to validate it.
  validate :check_image_url # Check that url for image is valid. My custom method.
  
  mount_uploader :avatar, AvatarUploader
end