FactoryGirl.define do

  factory :user, aliases: [:place_leader] do
    #tos true
    birth_date Time.now
    phone '555555'
    indentifier '99999999999'
    email 'test@fcr.com'
    password 'password'
    first_name 'nombre'
    last_name 'apellido'
  end

end

