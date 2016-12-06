# encoding: UTF-8
class Admin::HospitalsController < Admin::AdminController
  
  before_filter :set_menu

  def index
    @hospitals = Hospital.all.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @hospital = Hospital.new
    render :edit
  end

  def create
    @hospital = Hospital.new(hospital_params) # params[:hospital])
    if @hospital.save
      flash[:notice] = "Hospital #{@hospital.name} guardada"
      redirect_to admin_hospitals_path and return
    else
      flash[:error] = "Hospital #{@hospital.name} no pudo ser guardada"
      render :edit
    end
  end

  def edit
    @hospital = Hospital.find(params[:id])
  end
  

  def update

    @hospital = Hospital.find(params[:id])
 
    if @hospital.save
      flash[:notice] = "Hospital #{@hospital.name} guardado"
      redirect_to admin_hospitals_path and return
    else
      render :edit
    end
    
  end

  def destroy
    hospital = Hospital.find(params[:id])
    hospital.destroy
    flash[:ok] = "Hospital #{hospital.name} deleted"
    redirect_to admin_hospitals_path
  end

  private 

  def set_menu
    @selected_menu = 'Hospitals'
  end

  def hospital_params
    params.require(:hospital).permit(:city_id, :name)
  end





end
