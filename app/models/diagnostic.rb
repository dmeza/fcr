class Diagnostic < ActiveRecord::Base
  has_many :children, dependent: :destroy

   validates_presence_of :name
   
end