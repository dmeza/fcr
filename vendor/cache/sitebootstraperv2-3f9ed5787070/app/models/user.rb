require 'open-uri'
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:twitter, :facebook, :google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :is_admin, :lat, :lng, :photo, :phone

  has_many :authentications, :dependent => :destroy

  before_create :set_first_admin

  has_attached_file :photo, {
      :url => "/system/:class/:attachment/:id/:style_:basename.:extension",
      :path => ":rails_root/public/system/:class/:attachment/:id/:style_:basename.:extension",
      :styles => {
        :thumbnail => "60x60>",
        :original => "250x250>"
      },
      :default_url => "/assets/default_user.png"
  }

  def status
    active_for_authentication? ? 'active' : 'pending'
  end

  def full_name
    return "#{first_name} #{last_name}" if !first_name.blank? and !last_name.blank?
    return first_name if !first_name.blank?
    return last_name if !last_name.blank?
    return email if email
    ''
  end

  def password_required?
    (authentications.empty? && !persisted?) || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    authentications.empty?
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
    self.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => (omniauth['credentials']['token'] rescue nil), :secret => (omniauth['credentials']['secret'] rescue nil)) if !self.persisted? || !self.authentications.exists?(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def set_photo_from_url(image_url)
    if !image_url.blank? || self.photo_file_name.blank? || self.photo_file_name == 'default_user.png'
      begin
        io = open(URI.parse(image_url))
        def io.original_filename; base_uri.path.split('/').last end
        if !io.original_filename.blank?
          self.photo = io
        end
      rescue Exception => ex
        logger.error("ERROR ERROR ERROR ::: #{ex.message}")
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.omniauth"]
        user.apply_omniauth(data)
      end
    end
  end

  private

  def set_first_admin
    self.is_admin = true if User.where(:is_admin => true).count == 0
  end

end
