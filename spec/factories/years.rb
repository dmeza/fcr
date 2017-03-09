FactoryGirl.define do

  factory :year, aliases: [:collect_year], class: Collect::Year do
    year 2017
    event_date Time.now
  end

end

