class EventType < ActiveRecord::Base

  #attr_accessible :name, :requires_inception, :is_inception, :has_limit

  validates_presence_of :name

  has_many  :events

end