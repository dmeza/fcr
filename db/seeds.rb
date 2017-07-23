# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
City.find_or_create_by(name: 'Guayaquil')
City.find_or_create_by(name: 'Ambato')
City.find_or_create_by(name: 'Cuenca')
City.find_or_create_by(name: 'Ibarra')
City.find_or_create_by(name: 'Portoviejo')
City.find_or_create_by(name: 'Puyo')
City.find_or_create_by(name: 'Santo Domingo')
City.find_or_create_by(name: 'Loja')
City.find_or_create_by(name: 'Riobamba')
