class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize_user #Before going further call method authorize user.
  
  helper_method :current_user


  private

    def current_user
      unless session[:user_id].nil?
        User.find(session[:user_id])
      end
    end

  	def authorize_user
      @lists = List.all
      url = request.path_info
      if User.find_by_id(session[:user_id])
        if url.include?('landing') # if url is landing or root.
          render :layout => 'landing'
        end
      else
        if ["lists", "list_items"].any? { |string| url.include?(string) } # checks if any of the paths that not logged in users are able to access.
        elsif url.include?('landing') or url == "/" # if url is landing or root.
          render :layout => 'landing'
        else
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
