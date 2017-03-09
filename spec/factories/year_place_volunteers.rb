FactoryGirl.define do

  factory :year_place_volunteer, class: Collect::YearPlaceVolunteer do
    year_place
    first_name 'Voluntario'
    last_name 'FCR'
    phone '5555555'
    email 'volunteer@fcr.com'
    state 'Pendiente'
  end

end
