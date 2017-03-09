FactoryGirl.define do

  factory :place, aliases: [:collect_place], class: Collect::Place do
    city 
    name 'esquina'
    address 'la que cruza'
  end

end

