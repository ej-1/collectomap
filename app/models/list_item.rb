class ListItem < ActiveRecord::Base
	belongs_to :lists
	validates :title, :description ,presence: true # adress is optional
end