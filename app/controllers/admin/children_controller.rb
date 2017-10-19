# encoding: UTF-8
class Admin::ChildrenController < Admin::AdminController

  before_filter :set_menu

  def index
    @children = Child.paginate(page: params[:page], per_page: 50).order('created_at desc')
  end


  def new
    @child = Child.new
    @hospital = Hospital.new
    render :edit
  end

  def create
    @child = Child.new(child_params) # params[:hospital])
    if @child.save
      flash[:notice] = "Niño #{@child.name} guardada"
      redirect_to admin_children_path and return
    else
      flash[:error] = "Niño #{@child.name} no pudo ser guardada"
      render :edit
    end
  end

  def edit
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
 
    if @child.save
      flash[:notice] = "Niño #{@child.name} guardado"
      redirect_to admin_children_path and return
    else
      render :edit
    end
  end


  def destroy
    child = Child.find(params[:id])
    child.destroy
    flash[:ok] = "Niño #{child.name} borrado"
    redirect_to admin_children_path

    
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

  private
  
  def set_menu
    @selected_menu = 'Children'
  end

  def child_params
    params.require(:child).permit(:hospital_id, :diagnostic_id, :child_status_id, :genere,
                   :city_id, :name, :birth_date, :dream, :address  )
  end

  
end
