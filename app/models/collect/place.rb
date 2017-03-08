class Collect::Place < ActiveRecord::Base
  self.table_name_prefix = 'collect_'

  validates_presence_of :city_id, :name, :address

  belongs_to :city
  has_many :year_places, dependent: :destroy

end
