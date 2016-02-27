# encoding: UTF-8
class EventImage < ActiveRecord::Base

  #attr_accessible :image
  belongs_to :event

  #Load Image
  has_attached_file :image, :styles => {
    :thumb => "100x100>",
    :large => "300x300>"
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/, :message => 'no válida'

end