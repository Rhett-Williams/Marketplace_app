class ApplicationController < ActionController::Base
    
    private
    def is_admin?
        unless current_user.admin?
            redirect_to root_url, notice: "You are not an admin" and return
        end
    end
end