class RelativeType < ActiveRecord::Base
  has_many :relatives, dependent: :destroy
end