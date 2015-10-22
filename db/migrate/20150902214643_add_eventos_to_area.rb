class AddEventosToArea < ActiveRecord::Migration
  def up
    Area.create(name: 'eventos', color: 'eventos')
  end

  def down
    Area.find_by_name('eventos').destroy
  end
end
