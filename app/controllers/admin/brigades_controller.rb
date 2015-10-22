class Admin::BrigadesController < Admin::AdminController
	before_filter :set_menu
	 def index
    @brigades = Brigade.order('name asc').paginate(:page => params[:page], :per_page => 50)
  end

  def edit
    @brigade = Brigade.find(params[:id])
  end

  def new
    @brigade = Brigade.new
    render :edit
  end

  def create
    @brigade = Brigade.new(params[:brigade])
    if @brigade.save
      flash[:notice] = "Brigada #{@brigade.name} guardada"
      redirect_to admin_brigades_path and return
    else
      flash[:error] = "Brigada #{@brigade.name} no pudo ser guardada"
      render :edit
    end
  end

  def destroy
    @brigade = Brigade.find(params[:id])
    @brigade.destroy
    redirect_to admin_brigades_url
  end

  def update
    @brigade = Brigade.find(params[:id])
    @brigade.attributes = params[:brigade]
    if @brigade.save
      flash[:notice] = "Brigada #{@brigade.name} guardada"
      redirect_to admin_brigades_path and return
    else
      flash[:error] = "Brigada #{@brigade.name} no pudo ser guardada"
      render :edit
    end
  end

  private

  def set_menu
    @selected_menu = 'Brigades'
  end

end