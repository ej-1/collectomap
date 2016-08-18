class Sublist < ActiveRecord::Base
	has_many :sublist_items, dependent: :destroy
	belongs_to :lists
	before_destroy :ensure_not_referenced_by_any_sublist_item
  validates :title, :description, presence: true
end
