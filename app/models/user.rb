require 'my_custom_methods'

class User < ActiveRecord::Base
  include MyCustomMethods
  has_many :lists, dependent: :destroy
  validates :name, presence: true, uniqueness: true # Validates user name does has been submitted and does not already exist when creatin new user.
  has_secure_password # Rails - Forces the user to type the password again to validate it.
  validate :check_image_url # Check that url for image is valid. My custom method.
  mount_uploader :avatar, AvatarUploader
end