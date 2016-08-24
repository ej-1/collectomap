class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize_user #Before going further call method authorize user.

	def authorize_user
		unless User.find_by_id(session[:user_id])
			redirect_to login_url, notice: "Please log in"
		end
	end

end
