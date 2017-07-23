class Area < ActiveRecord::Base

  # attr_accessible :name, :color

  #validates_presence_of :name

  has_many :events, dependent: :nullify

end