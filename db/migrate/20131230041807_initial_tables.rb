# encoding: UTF-8
class InitialTables < ActiveRecord::Migration
  def up

    create_table :event_types do |t|
      t.string :name, limit: 200, null: false
      t.boolean :requires_inception, default: true
      t.boolean :is_inception, default: false
      t.timestamps
    end
    add_column :event_types, :has_limit, :boolean, default: false, null:false

    induccion = EventType.create!(name: 'Inducción', requires_inception: false, is_inception: true)
    voluntariado = EventType.create!(name: 'Voluntariado', requires_inception: true, has_limit: true)
    EventType.create!(name: 'Formación', requires_inception: true)
    EventType.create!(name: 'Colecta', requires_inception: false)

    create_table :areas do |t|
      t.string :name, limit: 200, null: false
      t.string :color, limit: 20, null: false, default: 'blue'
      t.timestamps
    end

    Area.create!(name: 'salud', color: 'red')
    area = Area.create!(name: 'educación', color: 'blue')
    Area.create!(name: 'investigación', color: 'green')
    Area.create!(name: 'recreación', color: 'yellow')

    create_table(:events) do |t|
      t.string :name, limit: 200, null: false
      t.text :description, limit: 100
      t.integer :spaces, default: 1, null: false
      t.integer :used, default: 0, null: false
      t.datetime :event_date, null: false
      t.string :place, null: false
      t.string :state, null: false, default: Event::EVENT_STATES[0]
      t.timestamps
    end

    add_column :events, :event_type_id, :integer, null: false
    add_column :events, :responsable_id, :integer
    add_column :events, :city_id, :integer
    add_column :events, :requires_adult, :boolean, default: false
    add_column :events, :area_id, :integer, null: false
    add_column :events, :role, :string, limit: 255
    add_column :events, :activation_date, :datetime, null: false

    add_column :users, :has_induction, :boolean, default: false
    add_column :users, :birth_date, :date
    add_column :users, :indentifier, :string, limit: 20
    add_column :users, :contact_me, :boolean
    add_column :users, :has_institution_induction, :boolean
    add_column :users, :mobile, :string, limit: 30
    add_column :users, :motivation, :text
    add_column :users, :brigade_id, :integer, null: true
    add_column :users, :city_id, :integer

    create_table(:events_users) do |t|
      t.references :user, :event, null: false
      t.datetime :created_at
    end
    add_column :events_users, :is_brigadist, :boolean, null: false, default: false

    user = User.create!(email: 'david@alturasoluciones.com', password: 'test1234', first_name: 'David', last_name: 'Meza', is_admin: true, birth_date: '1976/06/09', indentifier: '1707096549', phone: '+5931234567')
    user.confirm!

    induction = Event.create!(name: 'Inducción 1', description: '', spaces: 5, used: 0, event_type_id: induccion.id, event_date: (DateTime.now + 3.days), place: 'UTE', area_id: area.id, role: 'Ayuda en ejecución', responsable_id: user.id, activation_date: Date.today)
    induction2 = Event.create!(name: 'Inducción 2', description: '', spaces: 5, used: 0, event_type_id: induccion.id, event_date: (DateTime.now + 5.days), place: 'Universidad Catolica', area_id: area.id, role: 'Ayuda en ejecución', responsable_id: user.id, activation_date: Date.today)
    evento = Event.create!(name: 'Evento 1', description: '', spaces: 4, used: 0, event_type_id: voluntariado.id, event_date: (DateTime.now + 4.days), place: 'UTE', area_id: area.id, role: 'Ayuda en ejecución', responsable_id: user.id, activation_date: Date.today)
    evento2 = Event.create!(name: 'Evento 2', description: '', spaces: 4, used: 0, event_type_id: voluntariado.id, event_date: (DateTime.now + 6.days), place: 'Universidad Catolica', area_id: area.id, role: 'Ayuda en ejecución', responsable_id: user.id, activation_date: Date.today)

    volunteer1 = User.create!(email: 'david+v1@alturasoluciones.com', password: 'test1234', first_name: 'Volunteer1', last_name: 'Meza', birth_date: '1976/06/09', indentifier: '1707096541', phone: '+5931234567')
    volunteer2 = User.create!(email: 'david+v2@alturasoluciones.com', password: 'test1234', first_name: 'Volunteer2', last_name: 'Meza', birth_date: '1976/06/09', indentifier: '1707096542', phone: '+5931234567')
    volunteer3 = User.create!(email: 'david+v3@alturasoluciones.com', password: 'test1234', first_name: 'Volunteer3', last_name: 'Meza', birth_date: '1976/06/09', indentifier: '1707096543', phone: '+5931234567')
    volunteer4 = User.create!(email: 'david+v4@alturasoluciones.com', password: 'test1234', first_name: 'Volunteer4', last_name: 'Meza', birth_date: '1976/06/09', indentifier: '1707096544', phone: '+5931234567')

  end

  def down
    drop_table :events_users
    remove_column :users, :city_id
    remove_column :users, :brigade_id
    remove_column :users, :birth_date
    remove_column :users, :indentifier
    remove_column :users, :contact_me
    remove_column :users, :has_institution_induction
    remove_column :users, :has_induction
    remove_column :users, :mobile
    remove_column :users, :motivation
    drop_table :events
    drop_table :areas
    drop_table :event_types
  end
end
