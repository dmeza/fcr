# encoding: UTF-8
class Admin::EventsController < Admin::AdminController

  before_filter :set_menu

  def index
    @events = Event.paginate(:page => params[:page], :per_page => 50).order('event_date desc')
  end

  def new
    @event = Event.new
    render :edit
  end

  def create
    @event = Event.new(params[:event])
    if @event.event_date
      @event.event_date = DateTime.new(@event.event_date.year, @event.event_date.month, @event.event_date.day, params[:event_date_hour].to_i, params[:event_date_minute].to_i, 0, 0)
      @event.end_time = Time.new(@event.event_date.year, @event.event_date.month, @event.event_date.day, params[:event_end_time_hour].to_i, params[:event_end_time_minute].to_i, 0, 0)
    end
    #@event.event_date.change({hour: params[:event_date_hour], min: params[:event_date_minute]})
    if @event.brigade_id.present? && @event.brigade.brigade_leader_id.present?
      @event.responsable_id =  @event.brigade.brigade_leader_id
    end
    if @event.save
      flash[:notice] = "Evento #{@event.name} guardado"
      redirect_to admin_events_path and return
    else
      flash[:error] = "Evento #{@event.name} no pudo ser guardado"
      render :edit
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def edit_new
    @event = Event.find(params[:id])
    @event_image = @event.event_images.new
  end

  def destroy_image
    @event_image = EventImage.find(params[:id])
    event_id = @event_image.event_id
    @event_image.destroy
    redirect_to edit_new_admin_event_path(event_id)
  end

  def update
    @event = Event.find(params[:id])
    @event.attributes = params[:event]
    if @event.event_date
      @event.event_date = DateTime.new(@event.event_date.year, @event.event_date.month, @event.event_date.day, params[:event_date_hour].to_i, params[:event_date_minute].to_i, 0, 0)
      @event.end_time = Time.new(@event.event_date.year, @event.event_date.month, @event.event_date.day, params[:event_end_time_hour].to_i, params[:event_end_time_minute].to_i, 0, 0)
    end
    if @event.brigade_id.present? && @event.brigade.brigade_leader_id.present?
      @event.responsable_id =  @event.brigade.brigade_leader_id
    end
    if @event.save
      flash[:notice] = "Evento #{@event.name} guardado"
      redirect_to admin_events_path and return
    else
      flash[:error] = "Evento #{@event.name} no pudo ser guardado"
      if params[:edit_page_flag]=='edit_new'
        render :edit_new  
      else
        render :edit
      end
    end
  end

  def add_image
    @event = Event.find(params[:id])
    @event_image = @event.event_images.new(params[:event_image])
    if @event_image.save
      flash[:notice] = "Imagen para evento #{@event.name} guardada"
      redirect_to edit_new_admin_event_path(@event.id) and return
    else
      flash[:error] = "Imagen para evento #{@event.name} no pudo ser guardada"
      render :edit_new 
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_url
  end

  def responsable_autocomplete
    term = "%#{params[:term].downcase}%"
    user = User.where("lower(first_name) like ? or lower(last_name) like ? or lower(concat(first_name,' ',last_name)) like ?", term, term, term)
    render json: user.collect{|u|  {id: u.to_param, value: u.name}}.to_json
  end

  def entry_list
    @event = Event.find(params[:id])
    @events_users = @event.events_users.includes(:user).paginate(:page => params[:page], :per_page => 50)
    # @users = @event.users.paginate(:page => params[:page], :per_page => 50)
  end

  def remove_participant
    event_user = Event.find(params[:id]).events_users.find_by_user_id(params[:uid])
    if event_user
      event_user.destroy
      render js: "$('#volunteer_#{params[:uid]}').remove();"
    else
      render js: "alert('No se pudo remover al voluntario del evento');"
    end
  end

  def entry_list_to_xlsx
    @event = Event.find(params[:id])
    @events_users = @event.events_users.includes(:user)
    headers['Content-Disposition'] = "attachment; filename=Inscritos_#{@event.name}_#{Date.today.strftime('%Y/%m/%d')}.xlsx"
  end

=begin
  def entry_list_to_csv
    @event = Event.find(params[:id])
    users = @event.users

    csv_string = "Nombre, Email, Cédula, FechaNacimiento\r\n"
    users.each do |user|
      csv_string << "#{user.full_name}, #{user.email}, #{user.indentifier}, #{user.birth_date.strftime("%Y-%m-%d") unless user.birth_date.nil?}\r\n"
    end
    send_data csv_string.encode("UTF-8"), :type => "text/csv; charset=utf-8; header=present", :filename =>
        "inscritos_#{@event.name}_#{Time.now.strftime("%m-%d-%Y")}.csv", :disposition =>
        'attachment'
  end
=end

  def events_filter
    if(params[:event_type_id].present? && params[:start_date].present? && params[:end_date].present?)
      params[:end_date] = (params[:end_date].present? ? DateTime.strptime(params[:end_date], '%Y-%m-%d') : Time.now)
      params[:end_date] = params[:end_date].end_of_day+ 1.hour
      params[:start_date] = (params[:start_date].present? ? DateTime.strptime(params[:start_date], '%Y-%m-%d') : (params[:end_date] - 30.days))
      params[:start_date] = params[:start_date].beginning_of_day
      @events = Event.where('event_date >= ? AND event_date <= ? AND event_type_id = ? ', params[:start_date], params[:end_date], params[:event_type_id]).order('created_at DESC').paginate(per_page: 100, page: params[:page]) 
    elsif(params[:event_type_id].present?)
      @events = Event.where('event_type_id = ? ', params[:event_type_id]).paginate(:page => params[:page], :per_page => 50)
    elsif(params[:start_date].present? && params[:end_date].present?) 
      params[:end_date] = (params[:end_date].present? ? DateTime.strptime(params[:end_date], '%Y-%m-%d') : Time.now)
      params[:end_date] = params[:end_date].end_of_day + 1.hour
      params[:start_date] = (params[:start_date].present? ? DateTime.strptime(params[:start_date], '%Y-%m-%d') : (params[:end_date] - 30.days))
      params[:start_date] = params[:start_date].beginning_of_day
      @events = Event.where('event_date >= ? AND event_date <= ?', params[:start_date], params[:end_date]).order('created_at DESC').paginate(per_page: 100, page: params[:page])
    elsif(!params[:event_type_id].present?)
      @events = Event.paginate(:page => params[:page], :per_page => 50).order('event_date desc')
    end
    respond_to do |format|
      format.html {}
      format.js { render :index }
    end
  end


  private

  def set_menu
    @selected_menu = 'Events'
  end

end
