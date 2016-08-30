class List < ActiveRecord::Base
  has_many :sublists, dependent: :destroy
  has_many :list_items, dependent: :destroy
  before_destroy :ensure_not_referenced_by_any_list_item
  before_destroy :ensure_not_referenced_by_any_sublist
  validates :title, :description, :user_id, presence: true
  
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
