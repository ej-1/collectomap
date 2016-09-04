class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy
  validates :name, presence: true, uniqueness: true # Validates user name does has been submitted and does not already exist when creatin new user.
  has_secure_password # Rails - Forces the user to type the password again to validate it.
  mount_uploader :avatar, AvatarUploader
end