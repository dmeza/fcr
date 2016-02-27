# encoding: UTF-8
class Admin::VolunteersController < Admin::AdminController

  before_filter :set_menu

  def index
    @volunteers = User.paginate(page: params[:page], per_page: 50).order('created_at desc')
  end

  def edit
    @volunteer = User.find(params[:id])
  end

  def update
    @volunteer = User.find(params[:id])
    @volunteer.attributes = volunteer_params # params[:user]
    if @volunteer.save
      flash[:notice] = "Voluntario #{@volunteer.name} guardado"
      redirect_to admin_volunteers_path and return
    else
      flash[:error] = "Voluntario #{@volunteer.name} no pudo ser guardado"
      render :edit
    end
  end

  def activate
    volunteer = User.find(params[:id])
    volunteer.update_attribute('has_induction', true)
    render :js => "$('td.activation_#{volunteer.id}').html('Activo');" #alert('#{volunteer.email} esta activo ahora.');"
  end


  def to_xlsx
    @users = User.all
    headers['Content-Disposition'] = "attachment; filename=Voluntarios_#{Date.today.strftime('%Y/%m/%d')}.xlsx"
  end

=begin
  def to_csv
    users = User.all

    csv_string = "Nombre, Email, Cédula, Fecha Nacimiento, Fecha registro, Brigada, Recibir más información?, Inducción en su empresa?'\r\n"
    users.each do |user|
      csv_string << "#{user.full_name}, #{user.email}, #{user.indentifier}, #{user.birth_date.strftime("%Y-%m-%d") unless user.birth_date.nil?}, #{user.created_at.strftime("%Y-%m-%d %H:%M")}, #{user.brigade.name if user.brigade_id}, #{user.contact_me ? 'Sí' : 'No'}, #{user.has_institution_induction ? 'Sí' : 'No'}\r\n"
    end
    send_data csv_string.encode("UTF-8"), :type => "text/csv; charset=utf-8; header=present", :filename =>
        "voluntarios_#{Time.now.strftime("%m-%d-%Y")}.csv", :disposition =>
        'attachment'
  end
=end

  def volunteer_filter
    @volunteers = User.order('created_at desc')
    if (params[:brigade_id].present?)
      @volunteers = @volunteers.where('brigade_id = ? ', params[:brigade_id])
    end
    if (params[:voluntary_id].present?)
      @volunteers = @volunteers.where('id = ? ', params[:voluntary_id])
    end
    if (params[:email].present?)
      @volunteers = @volunteers.where('email = ?', params[:email])
    end
    if(params[:start_date].present? && params[:end_date].present?) 
      params[:end_date] = (params[:end_date].present? ? DateTime.strptime(params[:end_date], '%Y-%m-%d') : Time.now)
      params[:end_date] = params[:end_date].end_of_day
      params[:start_date] = (params[:start_date].present? ? DateTime.strptime(params[:start_date], '%Y-%m-%d') : (params[:end_date] - 30.days))
      params[:start_date] = params[:start_date].beginning_of_day
      @volunteers = @volunteers.where('created_at >= ? AND created_at <= ?', params[:start_date], params[:end_date])
    end
    if(params[:city_id].present? )
      @volunteers = @volunteers.where('city_id = ?', params[:city_id])
    end
    @volunteers = @volunteers.paginate(page: params[:page], per_page: 50)
    respond_to do |format|
      format.html {}
      format.js { render :index }
    end
  end

  private
  
    def set_menu
      @selected_menu = 'Volunteers'
    end

    def volunteer_params
      params.require(:user).permit(:tos, :has_induction, :birth_date, :indentifier, :contact_me, :has_institution_induction, :mobile, :motivation, :brigade, :brigade_id, :city_id, :city)
    end
end
