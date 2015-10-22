require Sitebootstrapperv2::Engine.root.join('app', 'models', 'user')
class User < ActiveRecord::Base

  devise :token_authenticatable
 

  attr_accessible :tos, :has_induction, :birth_date, :indentifier, :contact_me, :has_institution_induction, :mobile, :motivation, :brigade, :brigade_id, :city_id, :city

  validates_acceptance_of :tos, :message => 'deben ser aceptados'
  validates_presence_of :birth_date, :phone
  validates :indentifier, uniqueness: true, presence: true

  has_many :events_users, dependent: :destroy
  has_many :events, through: :events_users
  # has_and_belongs_to_many :events
  
  belongs_to :brigade
  belongs_to :city
  has_attached_file :photo, {
      :url => "/system/:class/:attachment/:id/:style_:basename.:extension",
      :path => ":rails_root/public/system/:class/:attachment/:id/:style_:basename.:extension",
      :styles => {
          :thumbnail => "60x60>",
          :original => "250x250>"
      },
      :default_url => "/assets/default_user.png"
  }

  def is_admin?
    is_admin
  end

  def has_induction?
    self.has_induction
  end

  def is_adult?
    (self.birth_date.nil? ? false : 18.years.ago >= self.birth_date)
  end
 
  def is_brigade_leader?
    return Brigade.where(brigade_leader_id: self.id).count > 0
  end
 
  def is_event_responsable?
    return Event.where(responsable_id: self.id).count > 0
  end

  def name
    full_name
  end

  def profile_not_complete?
    return true if(self.first_name.blank? || self.last_name.blank? || self.email.blank?)
    return false
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank? && !omniauth['info']['email'].blank?
    if (!omniauth['info']['first_name'].blank? && !omniauth['info']['last_name'].blank?)
      self.first_name ||= omniauth['info']['first_name']
      self.last_name ||= omniauth['info']['last_name']
    elsif (!omniauth['info']['name'].blank?)
      name_array = omniauth['info']['name'].split(' ')
      self.first_name ||= name_array.first
      self.last_name ||= name_array[1..name_array.length].join(' ')
    end
    set_photo_from_url(omniauth['info']['image'])
    self.authentications.build(provider: omniauth['provider'], uid: omniauth['uid'], token: (omniauth['credentials']['token'] rescue nil), secret: (omniauth['credentials']['secret'] rescue nil)) if !self.persisted? || !self.authentications.exists?(provider: omniauth['provider'], uid: omniauth['uid'])
  end

end
