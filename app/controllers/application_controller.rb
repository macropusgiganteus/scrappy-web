class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
      # If session[:user_id] is nil, set it to nil, otherwise find the user by id.
      @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !!current_user
    end
    
    def require_login
        unless logged_in?
            redirect_to login_path, alert: "You must be logged in to access this section"
        end
    end
end
