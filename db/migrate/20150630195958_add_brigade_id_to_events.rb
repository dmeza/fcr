class AddBrigadeIdToEvents < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.references :brigade
      t.time :end_time
    end

    Event.update_all("end_time='00:00'")

    Area.create(name: 'emprendimiento', color: 'emprendimiento')
    Area.create(name: 'deporte', color: 'deporte')
  end

  def down
    Area.find_by_name('emprendimiento').destroy
    Area.find_by_name('deporte').destroy
    remove_column :events, :end_time
    remove_column :events, :brigade_id
  end
end
