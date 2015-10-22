require Sitebootstrapperv2::Engine.root.join('app', 'controllers', 'admin', 'admin_controller')
class Admin::AdminController < ApplicationController

  before_filter :page_id, :events_count, :volunteers_count, :brigades_count

  layout 'admin'

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
end