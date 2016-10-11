class Sublist < ActiveRecord::Base
	has_many :list_items, dependent: :destroy
	belongs_to :lists
	before_destroy :ensure_not_referenced_by_any_sublist_item
  validates :title, :description, presence: true

  def ensure_not_referenced_by_any_sublist_item
    if list_items.empty?
      return true
    else
      errors.add(:base, 'Sublists present')
      return false
    end
  end

end
