require 'my_custom_methods'

class List < ActiveRecord::Base
  include MyCustomMethods
  has_many :sublists, foreign_key: "parent_id", class_name: "List", dependent: :destroy  # Declare explicitily name of Model with class_name, since a sublist model does not exist.
  has_many :list_items, dependent: :destroy
  before_destroy :ensure_not_referenced_by_any_list_item
  #before_destroy :ensure_not_referenced_by_any_sublist
  validates :title, :description, :user_id, presence: true
  validate :check_image_url # Check that url for image is valid. My custom method.
  mount_uploader :list_image, ImageUploader

  private

  # ensure that there are no list items referencing this product

  def ensure_not_referenced_by_any_list_item
    if list_items.empty?
      return true
    else
      errors.add(:base, 'List items present')
      return false
    end
  end

  def ensure_not_referenced_by_any_sublist
    if sublists.empty?
      return true
    else
      errors.add(:base, 'Sublists present')
      return false
    end
  end

end
