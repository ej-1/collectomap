class ListItem < ActiveRecord::Base
	belongs_to :lists
	validates :title, :description ,presence: true # adress is optional
	validate :check_image_url # Check that url for image is valid.
	validates :description, :uniqueness => {:scope => [:title, :description]} # Add user id to check it unique to user.
	mount_uploader :image, ImageUploader

	validates :image, allow_blank: true, format: {
	with: %r{\.(gif|jpg|png)\z}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
	}

	def check_image_url
	  if self.remote_image_url.present? && self.remote_image_url.end_with?(".jpg", ".jpeg", ".pgn.") 
	  elsif self.remote_image_url.present?
	  	errors.add(:string, "Not valid image url. Make sure it is .jpg, .gif or .pgn.")
	  end
	end

end
