class Relative < ActiveRecord::Base
  belongs_to :child
  belongs_to :relative_type
  has_many :polls, as: :participant, dependent: :destroy
  has_many :event_histories, as: :participant, dependent: :destroy
end