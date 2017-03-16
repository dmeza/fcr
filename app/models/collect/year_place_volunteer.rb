class Collect::YearPlaceVolunteer < ActiveRecord::Base
  self.table_name_prefix = 'collect_'

  validates_presence_of :first_name, :last_name, :phone, :email, :state

  belongs_to :year_place, foreign_key: 'collect_year_place_id'

end
