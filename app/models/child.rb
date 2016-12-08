class Child < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :diagnostic
  belongs_to :city
  belongs_to :child_status
  has_many :relatives, dependent: :destroy



  validates :hospital_id, :diagnostic_id, :child_status_id, 
                   :city_id, :name, :birth_date, :dream, :address,  presence: true

   
end