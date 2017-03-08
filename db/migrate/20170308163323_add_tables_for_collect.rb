class AddTablesForCollect < ActiveRecord::Migration
  def up

    add_column :users, :user_type, :string, null: false, limit: 50, default: 'voluntario'

    create_table :collect_places do |t|
      t.references :city, null: false
      t.string :name, null: false, limit: 400
      t.string :address, null: false, limit: 400
      t.float :lat
      t.float :lng
      t.timestamps
    end

    create_table :collect_year do |t|
      t.integer :year, null: false, limit: 4
      t.date :event_date, null: false
    end

    create_table :collect_year_places do |t|
      t.references :collect_place, null: false
      t.references :collect_year, null: false
      t.references :place_leader
      t.integer    :volunteer_count, null: false, limit: 2, default: 0
      t.string     :state, null: false, limit: 20, default: "Disponible"
      t.timestamps
    end

    create_table :collect_year_place_volunteers do |t|
      t.references :collect_year_place, null: false
      t.string     :first_name, limit: 100, null: false
      t.string     :last_name, limit: 100, null: false
      t.string     :phone, limit: 20
      t.string     :email, limit: 255, null: false
      t.string     :state, null: false, limit: 20, default: "Pendiente"
      t.timestamps
    end

  end

  def down
    drop_column :users, :user_type
    drop_table :collect_year_place_volunteers
    drop_table :collect_year_places
    drop_table :collect_year
    drop_table :collect_places
  end
end
