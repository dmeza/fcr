class Program < ActiveRecord::Base

  # attr_accessible :name, :description

  validates_presence_of :name

  has_many  :brigades

end