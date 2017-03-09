FactoryGirl.define do
  
  factory :year_place, aliases: [:collect_year_place], class: Collect::YearPlace do
    place_leader
    year
    place 
  end

end
