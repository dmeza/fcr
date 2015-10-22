require Sitebootstrapperv2::Engine.root.join('app', 'controllers','admin', 'users_controller')
class Admin::UsersController < Admin::AdminController

  def index
    if params[:user_id] && params[:user_id].to_i > 0
      @users = User.where(:id => params[:user_id]).paginate(:page => params[:page], :per_page => 50)
    else
      @users = User.order('first_name, last_name').paginate(:page => params[:page], :per_page => 50)
    end
  end
  def users_filter
  	if(params[:voluntary_id].present?)
  		@users = User.where('id = ? ', params[:voluntary_id]).paginate(:page => params[:page], :per_page => 50)
  	elsif (params[:email].present?)
  		@users = User.where('email = ? ', params[:email]).paginate(:page => params[:page], :per_page => 50)			
  	else
  		@users = User.order('created_at desc').paginate(:page => params[:page], :per_page => 50)	
  	end
  	respond_to do |format|
     format.html {}
     format.js { render :index }
    end

  end
end