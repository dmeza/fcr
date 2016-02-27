class Authentication < ActiveRecord::Base
  belongs_to(:user)

  #attr_accessible :token, :uid, :secret, :provider
end