class Child < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :diagnostic
  belongs_to :city
  belongs_to :child_status
  has_many :relatives, dependent: :destroy
end