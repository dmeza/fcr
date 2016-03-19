# encoding: UTF-8
class Admin::ChildrenController < Admin::AdminController

  before_filter :set_menu

  def index
    @children = Child.paginate(page: params[:page], per_page: 50).order('created_at desc')
  end

  def child_filter
    @children = Child.order('created_at desc')
    if (params[:child_name].present?)
      @children = @children.where('name LIKE ? ', "%" + params[:child_name] + "%")
    end
    if(params[:hospital_id].present? )
      @children = @children.where('hospital_id = ?', params[:hospital_id])
    end
    if(params[:city_id].present? )
      @children = @children.where('city_id = ?', params[:city_id])
    end
    if(params[:diagnostic_id].present? )
      @children = @children.where('diagnostic_id = ?', params[:diagnostic_id])
    end
    if (params[:child_dream].present?)
      @children = @children.where('dream LIKE ? ', "%" + params[:child_dream] + "%")
    end
    if(params[:city_id].present? )
      @children = @children.where('city_id = ?', params[:city_id])
    end
    if(params[:child_status_id].present? )
      @children = @children.where('child_status_id = ?', params[:child_status_id])
    end
    @children = @children.paginate(page: params[:page], per_page: 50)
    respond_to do |format|
      format.html {}
      format.js { render :index }
    end
  end

  def to_xlsx
    @children = Child.all
    headers['Content-Disposition'] = "attachment; filename=Ninos_#{Date.today.strftime('%Y/%m/%d')}.xlsx"
  end

=begin
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

  private
  
    def set_menu
      @selected_menu = 'Children'
    end
=begin
    def volunteer_params
      params.require(:user).permit(:tos, :has_induction, :birth_date, :indentifier, :contact_me, :has_institution_induction, :mobile, :motivation, :brigade, :brigade_id, :city_id, :city)
    end
=end
end
