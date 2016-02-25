class HomeController < ApplicationController
   before_filter :authenticate_user!, :except => [:index]

  def index
    render :home if current_user
  end

  def fb_channel
    response.headers["Expires"] = CGI.rfc1123_date(Time.now + 365.days)
    render :text => '<script src="//connect.facebook.net/en_US/all.js"></script>'
  end

  def return_to_admin
    user_admin = User.find(session["admin_user_id"])
    if(user_admin)
      sign_in(:user, user_admin)
      session["admin_user_id"] = nil
      redirect_to admin_users_path and return
    end
    redirect_to root_path
  end
end