module MyCustomMethods

  def check_image_url # Checks that image format is allowed. Blank images also allowed.

    if self.respond_to?(:remote_list_image_url) # check if method exist
      image_url = self.remote_list_image_url
    elsif self.respond_to?(:remote_image_url)
      image_url = self.remote_image_url
    elsif self.respond_to?(:remote_avatar_url)
      image_url = self.remote_avatar_url
    end

    if image_url.present? && !image_url.end_with?(".jpg", ".jpeg", ".png", ".gif") 
      errors.add(:string, "Not valid image url. Make sure it is .jpg, .jpeg, .png or .gif.")
    end
  end

end
