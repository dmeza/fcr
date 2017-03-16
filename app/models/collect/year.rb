class Collect::Year < ActiveRecord::Base
  self.table_name_prefix = 'collect_'

  validates_presence_of :year, :event_date

  has_many :year_places, dependent: :destroy

end
