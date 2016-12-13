require "rails_helper"
require 'support/controller_helpers'
require 'pp'



RSpec.describe Admin::PollsController, :type => :controller do
  
  describe "GET index" do
    
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all the polls into @polls" do 
      poll1 = Poll.create!(participant_id: 1, participant_type: 'voluntario', code: '1234', poll_date: Date.today )
      poll2 = Poll.create!(participant_id: 1, participant_type: 'voluntario', code: '1234', poll_date: Date.today )
      get :index

      expect(assigns(:polls)).to match_array([poll1, poll2])
    end  
  end

  describe "Get from_xlsx" do

    context 'when file has no errors' do
      
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
        sign_in user
      end

      it 'shows the right flash messages' do 
        path = File.join(Rails.root, 'spec', 'support', 'example1.xlsx')
        post :from_xlsx, upload: { datafile: Rack::Test::UploadedFile.new( path )}
        expect(response).to redirect_to(admin_polls_path)
        expect(flash[:notice]).to match "Tus Archivos fueron guardados correctemente"
      end    

    end

    context 'when file has errors' do
      
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
        sign_in user
      end

      it 'shows the right flash messages' do 
        path = File.join(Rails.root, 'spec', 'support', 'example2.xlsx')
        post :from_xlsx, upload: { datafile: Rack::Test::UploadedFile.new( path )}
        expect(response).to redirect_to(admin_polls_path)
        expect(flash[:notice]).to match "Tus Archivos fueron guardados, pero contienen errores. [\"Error en la creacion de City: Validation failed: Name can't be blank\", \"Error en la creacion de Hospital: Validation failed: Name can't be blank\", \"Error en la creacion de Child: Validation failed: Diagnostic can't be blank\", \"Error en la creacion de ChildStatus: Validation failed: Name can't be blank\", \"Error en la creacion de Child: Validation failed: Name can't be blank\"]"
      end    
    end
  end
end


