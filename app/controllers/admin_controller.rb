class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin?

    def users
        @users = User.all.order("id ASC")
    end

    def requests 
        @requests = Request.all
    end

    def users_destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
          format.html { redirect_to admin_users_path, notice: "The account was successfully deleted" }
        end
    end

    def requests_destroy
        @request = Request.find(params[:id])
        @request.destroy
        respond_to do |format|
          format.html { redirect_to admin_users_path, notice: "The payment request was successfully deleted" }
        end
    end
end