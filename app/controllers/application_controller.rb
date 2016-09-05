class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize_user #Before going further call method authorize user.
  
  helper_method :current_user


  private

    def current_user
      User.find(session[:user_id])
    end

  	def authorize_user

      url = request.path_info
      if url.include?('landing')
        @lists = List.all
        render :layout => 'landing'
      else
        unless User.find_by_id(session[:user_id])
          redirect_to login_url, notice: "Please log in"
        end
      end
  	end

    def authorize_admin
      if User.find(session[:user_id]).admin == true
        true
      else
        false
      end
      rescue ActiveRecord::RecordNotFound
    end

end
