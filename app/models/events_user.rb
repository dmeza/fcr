class EventsUser < ActiveRecord::Base

  belongs_to  :event

  belongs_to  :user

  # attr_accessible :user_id, :event_id, :user, :event, :is_brigadist

  validates_presence_of :user_id, :event_id

  scope :brigadists, -> { where(is_brigadist: true) }
  scope :non_brigadists, -> { where(is_brigadist: false) }

  after_create :add_used_spaces
  before_destroy :reduce_used_spaces

  def add_used_spaces
    self.event.used = self.event.used + 1
    self.event.save 
  end

  def reduce_used_spaces
    self.event.used = self.event.used - 1
    self.event.save 
  end

end