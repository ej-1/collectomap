class SublistItem < ActiveRecord::Base
  belongs_to :sublists
  validates :title, :description ,presence: true # adress is optional
end
