class AddBirthDateToUsers < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :name, limit: 200, null: false
      t.timestamps
    end

    quito = City.create!(name: 'Quito')
    City.create!(name: 'Guayaquil')
    City.create!(name: 'Ambato')
    City.create!(name: 'Cuenca')
    City.create!(name: 'Ibarra')
    City.create!(name: 'Portoviejo')
    
    User.update_all(city_id: quito.id)
    Event.update_all(city_id: quito.id)

  end

  def down
    drop_table :cities
  end
end
