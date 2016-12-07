#require Sitebootstrapperv2::Engine.root.join('app', 'controllers', 'admin', 'admin_controller')
class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin

  before_filter :page_id, :events_count, :volunteers_count, :brigades_count, :children_count, :polls_count

  layout 'admin'

  def require_admin
    unless current_user.is_admin?
      flash[:error] = "You must be logged in as an admin to access this page"
      redirect_to root_path
    end
  end

  private

  def page_id
    @page_id = 'admin'
  end

  def events_count
    @eventsCount = Event.count('event_date', :distinct => true)
  end

  def volunteers_count
    @volunteersCount = User.count('email', :distinct => true)
  end

  def brigades_count
    @brigadesCount = Brigade.count('name', :distinct => true)
  end

  def children_count
    @childrenCount = Child.count('name', :distinct => true)
  end

<<<<<<< HEAD
  def hospital_count
    @hospitalsCount = Hospital.count('name', :distinct => true)
  end


=======
  def polls_count
    @pollsCount = Poll.count('code', :distinct => true)
  end
>>>>>>> 04a668290ec4cf1fcad1519a52aea0c2182ba1db
end