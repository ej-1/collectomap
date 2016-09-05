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

      url = request.path_info
      if url.include?('landing')
        @lists = List.all
        render :layout => 'landing'
      else
        unless User.find_by_id(session[:user_id])
          if ["lists", "list_items"].any? { |string| url.include?(string) } # checks if any of the paths that not logged in users are able to access.
          else
            redirect_to login_url, notice: "Please log in"
          end
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
