class Collect::YearPlace < ActiveRecord::Base
  self.table_name_prefix = 'collect_'

  validates_presence_of :volunteer_count, :state

  belongs_to :place, foreign_key: 'collect_place_id'
  belongs_to :year, foreign_key: 'collect_year_id'
  belongs_to :place_leader, class_name: 'User'

  has_many :year_place_volunteers, foreign_key: 'collect_year_place_id', dependent: :destroy

  def add_year_place_volunteers(first_name, last_name, phone, email)
    return { status: :fail, error_message: "Punto lleno" } if year_place_volunteers.count > 9
    year_place_volunteer = year_place_volunteers.create(first_name: first_name, last_name: last_name, phone: phone, email: email )
    return { status: :ok } if year_place_volunteer.persisted?
    { status: :fail, error_message: year_place_volunteer.errors.full_messages }
  end

end
