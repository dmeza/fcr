class CollectController < ApplicationController

  def add_volunteer
    year_place = Collect::YearPlace.find(params[:year_place_id])
    year_place.add_year_place_volunteers(params[:first_name], params[:last_name], params[:phone], params[:email])
  end
end
