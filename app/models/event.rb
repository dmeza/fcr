# encoding: UTF-8
# encoding: UTF-8
class Event < ActiveRecord::Base

  include ActionView::Helpers

  EVENT_TYPES = ['Inducción', 'Voluntariado']
  EVENT_STATES = ['Activo', 'Inactivo']
=begin
  attr_accessible :name, :description, :spaces, :used, :event_type, 
                  :event_type_id, :event_date, :state, :place,  
                  :responsable_id, :city_id, :city, :requires_adult, 
                  :area, :area_id, :role, :activation_date, :brigade_id
=end

  has_many :events_users, dependent: :destroy
  has_many :users, through: :events_users
  has_many :event_images, dependent: :destroy
  belongs_to :responsable, class_name: 'User'
  belongs_to :city
  belongs_to :area
  belongs_to :event_type
  belongs_to :brigade
  has_many :event_histories, dependent: :destroy

  before_save :set_default_area

  validates_presence_of :name, :spaces, :responsable_id ,:event_type, 
                        :event_date, :state, :place, :activation_date
  validates_presence_of :spaces, if: Proc.new {|e| e.event_type.has_limit }

  delegate :name, :email, to: :responsable, prefix: true, allow_nil: true

  scope :active, -> { where("state = '#{EVENT_STATES[0]}'") }
  scope :future, -> { where("event_date >= '#{DateTime.now}'").order('event_date asc') }
  scope :city, ->(city_id) { where("city_id = :city_id", city_id: city_id) }
  scope :before, ->(end_time) { where("event_date < :event_date", event_date: Event.format_date(end_time)) }
  scope :after, ->(start_time) { where("event_date > :event_date", event_date: Event.format_date(start_time)) }


  #scopes
  def self.induction(city_id)
    includes("event_type").where("event_types.is_inception = 1 and events.city_id = ?", city_id).references(:event_type)
  end

  def is_active?
    self.state.eql? EVENT_STATES[0]
  end

  def is_open?
    !self.event_type.requires_inception
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      id: self.id,
      title: get_title,
      description: self.description || "",
      start: self.event_date,
      end: self.event_date,
      allDay: false,
      recurring: false,
      className: (self.event_type.requires_inception ? self.area.color : self.event_type.name),
      url: Rails.application.routes.url_helpers.event_path(self.id)
    }
  end

  def get_title
    event_name = (self.event_type.requires_inception ? "#{self.event_type.name}: #{self.area.name}" : self.event_type.name)
    @cont = self.spaces- self.used
    if self.event_type.has_limit
      event_name = "#{event_name}\nEvento: #{self.name}\nCupos: #{@cont}"|| ""
    else
      event_name = "#{event_name}\nEvento: #{self.name}"|| ""
    end
    return "#{event_name}\nCiudad: #{city.name}"
  end

  def set_default_area
    self.area = Area.find_or_create_by(name: '') unless area_id.present?
  end

end