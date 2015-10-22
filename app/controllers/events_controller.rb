# encoding: UTF-8
class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def show
    @event = Event.find(params[:id])
    # p "@event:#{@event.inspect}:::@event.is_active?:#{@event.is_active?}::#{@event.state}::#{Event::EVENT_STATES[0]}"
    redirect_to root_path and return if !@event || !@event.is_active?
    @next_inductions = Event.induction(@event.city_id).future.limit(2)
  end

  def logged
    show
    render :show
  end

  def join
    @event = Event.find(params[:id])
    redirect_to root_path and return if !@event || !@event.is_active?

    if ((@event.activation_date || @event.created_at) > DateTime.now) # not open to registration yet
      flash[:notice] = "Los registros en línea se abrirán desde: #{(@event.activation_date ? @event.activation_date.strftime("%Y-%m-%d") : @event.created_at.strftime("%d/%m/%Y"))}"
    else
      if @event.event_date < (DateTime.now - 24.hours) # Registration is closed
          flash[:notice] = 'Los registros se deben realizar 24 horas antes del evento'
      else
        if @event.requires_adult && !current_user.is_adult?
          flash[:notice] = 'Este evento require que sea mayor de edad para poder participar'
        else
          if @event.is_open? || current_user.has_induction?
            available = @event.spaces - @event.used
            if @event.event_type.has_limit && available == 0 # no spaces available
              flash[:notice] = 'No hay cupos disponibles para este evento. Por favor revise otros eventos'
            else # spaces available
              @event.users << current_user
              @event.used = @event.users.count
              @event.save
              MessageMailer.joined(@event, current_user).deliver
              MessageMailer.new_register(@event, current_user).deliver
            end
          else
            flash[:notice] = 'Como pre-requisito, debe participar en una induccion antes de poder ser voluntario.'
            @next_inductions = Event.induction(@event.city_id).future.limit(2)
          end
        end
      end
    end
    render :show
  end

  def responsable_autocomplete
    term = "%#{params[:term].downcase}%"
    user = User.where("lower(first_name) like ? or lower(last_name) like ? or lower(concat(first_name,' ',last_name)) like ?", term, term, term)
    render json: user.collect{|u|  {id: u.to_param, value: u.name}}.to_json
  end

end
