
require 'rails_helper'

RSpec.describe CollectController, type: :controller do

  let(:year)  { FactoryGirl.create(:year) }
  let(:year_place)  { FactoryGirl.create(:year_place, year: year) }

  describe 'volunteers ' do
    it '-- add' do
       post :add_volunteer, {year_place_id: year_place.id}
    end
  end


end
