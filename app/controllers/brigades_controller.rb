class BrigadesController < ApplicationController
  before_filter :authenticate_user!, :set_menu

  layout 'admin'

  def index
    @brigades = Brigade.where(brigade_leader_id: current_user.id).order('name desc').paginate(page: params[:page])
  end

  def view_brigade
     @brigade = Brigade.where("id = ? and  brigade_leader_id =?", params[:id],  current_user.id).first
  end

  def dashboard
  	@events = Event.where(responsable_id: current_user.id).order('event_date desc').paginate(page: params[:page])
  end

  
  def view_event
    @event = Event.find(params[:id])
  end

  def add_brigadist
    @event = Event.find(params[:id])
    @events_user = @event.events_users.new({user_id: params[:user_id], is_brigadist: true})
    unless @events_user.save
      render js: "alert('Usuario no identificado. ')" and return
    end
  end 
  
  def remove_brigadist
    event = Event.find(params[:id])
    events_user = event.events_users.find(params[:events_user_id])
    if events_user.destroy
      render js: "$('.bigadist-#{params[:events_user_id]}').remove();"
    else
      render js: "alert('Usuario no identificado.');"
    end
  end

  private

  def set_menu
    @selected_menu = 'Brigades'
  end

end	