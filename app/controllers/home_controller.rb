#require Sitebootstrapperv2::Engine.root.join('app', 'controllers', 'home_controller')
class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :calendar]

  def index
    @city_id = params[:city_id]
    @events = Event.active
    @events = @events.city(params[:city_id]) if params[:city_id].present?
    @events = @events.paginate(page: params[:page], per_page: 50)
    render :home if current_user
  end

  def calendar
    @city_id = params[:city_id]
    @events = Event.active.after(params['start']).before(params['end'])
    @events = @events.city(@city_id) if @city_id.present?

    #@events = Event.all
    #@events = @events.after(params['start']) if (params['start'])
    #@events = @events.before(params['end']) if (params['end'])

    respond_to do |format|
      format.html # index.html.erb
      format.js  { render json: @events }
    end
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