class Brigade < ActiveRecord::Base

  # attr_accessible :name, :program, :program_id, :brigade_leader_id

  validates_presence_of :name

  belongs_to :program

  has_many :members, class_name: 'User', dependent: :nullify
  has_many :events, dependent: :nullify

  belongs_to :brigade_leader, class_name: 'User'

  delegate :name, to: :brigade_leader, prefix: true, allow_nil: true

  after_save :set_brigade_on_leader

  private

  	def set_brigade_on_leader
  		self.brigade_leader.update_attribute(:brigade_id, self.id) if self.brigade_leader_id.present?
  	end

end