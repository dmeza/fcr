class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin

  def require_admin
    unless current_user.is_admin?
      flash[:error] = "You must be logged in as an admin to access this page"
      redirect_to root_path
    end
  end
end
