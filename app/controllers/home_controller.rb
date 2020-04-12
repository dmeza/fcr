require Sitebootstrapperv2::Engine.root.join('app', 'controllers', 'home_controller')
class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :calendar]

  def index
    @city_id = (params[:city_id].nil? || params[:city_id] == "" ? 0 : params[:city_id])
    @events = Event.active.paginate(page: params[:page], per_page: 50)
    @events = @events.city(@city_id) unless @city_id == 0
    render :home if current_user
  end

  def calendar
    @city_id = (params[:city_id].nil? || params[:city_id] == "" ? 0 : params[:city_id])
    @events = Event.active.after(params['start']).before(params['end'])
    @events = @events.city(@city_id) unless @city_id == 0

    #@events = Event.all
    #@events = @events.after(params['start']) if (params['start'])
    #@events = @events.before(params['end']) if (params['end'])

    respond_to do |format|
      format.html # index.html.erb
      format.js  { render json: @events }
    end
  end
end