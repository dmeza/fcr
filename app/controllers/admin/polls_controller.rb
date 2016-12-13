# encoding: UTF-8
class Admin::PollsController < Admin::AdminController

  before_filter :set_menu



  def index
    @polls = Poll.paginate(page: params[:page], per_page: 50).order('created_at desc')
  end

  def poll_filter
    @polls = Poll.order('created_at desc')
    if(params[:code].present? )
      @polls = @polls.where('code = ?', params[:code])
    end
    if(params[:date].present? )
      @polls = @polls.where(poll_date: DateTime.strptime(params[:date], '%d/%m/%Y'))
    end
    @polls = @polls.paginate(page: params[:page], per_page: 50)
    respond_to do |format|
      format.html {}
      format.js { render :index }
    end
  end

  def to_xlsx
    @polls = Poll.all
    headers['Content-Disposition'] = "attachment; filename=Polls_#{Date.today.strftime('%Y/%m/%d')}.xlsx"
  end


  def from_xlsx

    uploaded_doc = Poll.save_file( params[:upload][:datafile].tempfile.to_path.to_s ) 
    
    @errors = uploaded_doc

    if @errors.empty?
      flash[:notice] = "Tus Archivos fueron guardados correctemente"
    else
      flash[:notice] = "Tus Archivos fueron guardados, pero contienen errores. #{@errors}"
    end

    redirect_to admin_polls_path



  end


  private
  
  def set_menu
    @selected_menu = 'Poll'
  end

end
