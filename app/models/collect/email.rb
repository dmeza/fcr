class Collect::YearPlaceVolunteer < ActiveRecord::Base
  self.table_name_prefix = 'collect_'

  validates_presence_of :email

end
