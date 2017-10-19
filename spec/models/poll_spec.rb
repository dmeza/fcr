require "rails_helper"
require 'roo'
require 'database_cleaner'
require 'pp'

RSpec.describe Poll, :type => :model do

	describe ".save_file" do

		context 'when file has no errors' do

	  		before(:each) do
			    file = File.join(Rails.root, 'spec', 'support', 'example1.xlsx')
				@errors = Poll.save_file(file)
				FactoryGirl.build(:hospital)
				FactoryGirl.create(:city)
			end

			it "should return no errors" do 
				expect(@errors.length).to eq(0)
			end

			it "should create right number of cities" do
				expect(City.count).to eq(4)
			end

			it "should create right number of hospitals" do
				expect(Hospital.count).to eq(5) # Hospital should be equal to 5
			end

			it "should create the right number of diagnostics" do 
				expect(Diagnostic.count).to eq(2)
			end

			it "should create the right number of status" do 
				expect(ChildStatus.count).to eq(3)
			end

			it "should create the right number of children" do 
				expect(Child.count).to eq(5)
			end
		end

		context 'when file has errors' do 

	  		before(:each) do
			    file = File.join(Rails.root, 'spec', 'support', 'example2.xlsx')
				@errors = Poll.save_file(file)
				FactoryGirl.build(:hospital)
				FactoryGirl.create(:city)
			end

			# Error 1 no tiene Ciudad
			# Error 2 no tiene Hospital
			# Error 3 no tiene Diagnostico
			# Error 4 no tiene Estado
			# Error 5 El nino no tiene nombre

			it "should return the right number of errors" do 
				expect(@errors.length).to eq(5)
			end

			it "should create right number of cities" do
				expect(City.count).to eq(5) 
			end

			it "should create right number of hospitals" do
				expect(Hospital.count).to eq(3) # Hospital should be equal to 3
			end

			it "should create the right number of diagnostics" do 
				expect(Diagnostic.count).to eq(2)
			end

			it "should create no children" do
				expect(Child.count).to eq(0)
			end

		end


	end 




end
