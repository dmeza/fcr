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

  private
  
  def set_menu
    @selected_menu = 'Children'
  end
  
end
