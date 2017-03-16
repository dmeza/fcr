class CollectController < ApplicationController

	def landing_page
  end

  def save_mail
  	email = params[:email]
  	redirect_to action: "register_volunteer_form", volunteer_email: email
  end

  def register_volunteer_form
  	@volunteer_email = params[:volunteer_email]
  end

  def register_volunteer_save
  	@volunteer = params[:user]
  	@volunteer.save
  end

  def volunteers
  end

  def add_volunteer
    year_place = Collect::YearPlace.find(params[:year_place_id])
    year_place.add_year_place_volunteers(params[:first_name], params[:last_name], params[:phone], params[:email])
  end

end
