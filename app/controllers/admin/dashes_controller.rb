class Admin::DashesController < Admin::AdminController

  before_filter :set_menu

  def show
    @nonactive_volunteers = User.where(has_induction: false).order('created_at desc').limit(20)
    @events = Event.order('event_date desc').paginate(:page => params[:page])
=begin
    @most_viewed_properties = Property.joins(:viewed_properties).group('properties.id').order('total desc').limit(5).select('properties.*, count(viewed_properties.id) as total')
    @most_contacted_properties = Property.joins(:property_viewers).group('properties.id').order('total desc').limit(5).select('properties.*, count(property_viewers.id) as total')

    @most_viewed_anouncers = Property.joins(:viewed_properties).group('properties.user_id').order('total desc').limit(5).select('properties.user_id, count(viewed_properties.id) as total')

    @anouncer_with_most_properties = User.joins(:properties).group('users.id').order('total desc').limit(5).select('users.*, count(properties.id) as total')
    @most_viewed_division = Property.joins(:viewed_properties).group('properties.division_id').order('total desc').limit(5).select('properties.division_id, count(viewed_properties.id) as total')
    @most_viewed_property_types = Property.joins(:viewed_properties).group('properties.property_type').order('total desc').select('properties.property_type, count(viewed_properties.id) as total')
=end
  end

  private

  def set_menu
    @selected_menu = 'Dash'
  end
end