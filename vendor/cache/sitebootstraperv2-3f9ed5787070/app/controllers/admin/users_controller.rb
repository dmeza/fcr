class Admin::UsersController < Admin::AdminController

  def index
    if params[:user_id] && params[:user_id].to_i > 0
      @users = User.where(:id => params[:user_id]).paginate(:page => params[:page], :per_page => 50)
    else
      @users = User.order('first_name, last_name').paginate(:page => params[:page], :per_page => 50)
    end
  end

  def resend_activation
    @user = User.find(params[:id])
    @user.send_confirmation_instructions
    #render :json => {:status => 1, :user_name => user.full_name}
  end

  def login_as
    new_user = User.find(params[:id])
    session["admin_user_id"] = current_user.id
    sign_in(:user, new_user)
    redirect_to root_path
  end

  def make_admin
    user = User.find(params[:id])
    user.update_attribute(:is_admin, true)
    flash[:ok] = "User #{user.email} is now admin"
    redirect_to admin_users_path
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:ok] = "User #{user.email} deleted"
    redirect_to admin_users_path
  end

  def to_csv
    users = User.order('last_name, first_name')
    csv_string = "Name, Email, Create at, Status, Last login, Role\r\n"
    users.each do |user|
      csv_string << "#{user.full_name}, #{user.email}, #{user.created_at.strftime("%Y-%m-%d %H:%M")}, #{user.status}, #{(user.last_sign_in_at ? user.last_sign_in_at.strftime("%Y-%m-%d %H:%M"):"never")}, #{(user.is_admin? ? 'Admin' :'')}\r\n"
    end
    send_data csv_string, :type => "text/csv; charset=utf-8; header=present", :filename => "user_accounts_#{Time.now.strftime("%m-%d-%Y")}.csv", :disposition => 'attachment'
  end

  def chart_data
    data = []
    days_to_show = 90
    (0..days_to_show).each do |offset|
      day = Time.now - (days_to_show-offset).days
      if(params[:type] == 'day')
        count = User.where(:created_at => day.beginning_of_day..day.end_of_day).count
      elsif(params[:type] == 'sum')
        count = User.where('created_at <= ?', day.end_of_day).count
      end
      data << [day.to_time.to_i * 1000, count]
    end

    render :json => {:type => params[:type], :data => data}
  end

end