require 'my_custom_methods'

class List < ActiveRecord::Base
  include MyCustomMethods
  has_many :sublists, foreign_key: "parent_id", class_name: "List", dependent: :destroy  # Declare explicitily name of Model with class_name, since a sublist model does not exist.
  has_many :list_items, dependent: :destroy
  validates :title, :description, :user_id, presence: true
  validate :check_image_url # Check that url for image is valid. My custom method.
  mount_uploader :list_image, ImageUploader
end
