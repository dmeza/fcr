class Collect::YearPlace < ActiveRecord::Base
  self.table_name_prefix = 'collect_'

  validates_presence_of :volunteer_count, :state

  belongs_to :place
  belongs_to :year
  belongs_to :place_leader, class_name: 'User'

  has_many :year_place_volunteers, dependent: :destroy

end
