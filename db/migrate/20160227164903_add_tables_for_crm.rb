class AddTablesForCrm < ActiveRecord::Migration
  def up

    create_table :hospitals do |t|
      t.references :city, null: false
      t.string :name, null: false
      t.timestamps
    end
    Hospital.create(city_id:1, name:"Hospital Baca Ortiz")
    Hospital.create(city_id:1, name:"Hospital Solca Quito")
    Hospital.create(city_id:1, name:"Hospital Voz Andes")

    create_table :diagnostics do |t|
      t.string :name, null: false
      t.timestamps
    end
    Diagnostic.create(name:"LEUCEMIA LINFOBLASTICA AGUDA")
    Diagnostic.create(name:"OSTEOSARCOMA")
    Diagnostic.create(name:"TUMORES")

    create_table :child_statuses do |t|
      t.string :name, null: false
      t.timestamps
    end
    ChildStatus.create(name:"EN TRATAMIENTO")
    ChildStatus.create(name:"MANTENIMIENTO")
    ChildStatus.create(name:"CONTROL")


    create_table :children do |t|
      t.references :hospital, null: false
      t.references :diagnostic, null: false
      t.references :child_status, null: false
      t.references :city, null: false
      t.string :name, null: false, limit: 255
      t.date :birth_date, null: false
      t.string :genere, null: false, limit: 50
      t.string :dream, limit: 500
      t.string :address, limit: 300
      t.integer :siblings_over_18
      t.integer :siblings_under_18
      t.timestamps
    end

    Child.create(hospital_id:1, diagnostic_id:1,child_status_id:1,city_id:1, name:"Mateo Perez",
      birth_date:"2003/02/15",genere:"Masculino",dream:"viajar a la playa",address: "valle",siblings_under_18:2,siblings_over_18:0)
    Child.create(hospital_id:1, diagnostic_id:1,child_status_id:1,city_id:1, name:"JUan Martinez",
      birth_date:"2003/05/15",genere:"Masculino",dream:"fiesta ",address: "recreo",siblings_under_18:0,siblings_over_18:0)
    Child.create(hospital_id:1, diagnostic_id:1,child_status_id:1,city_id:1, name:"Laura Perez",
      birth_date:"2003/08/15",genere:"Masculino",dream:"quiere minnie mouse",address: "norte",siblings_under_18:0,siblings_over_18:2)

    create_table :relative_types do |t|
      t.string :name, null: false
      t.timestamps
    end

    RelativeType.create(name:"padre")
    RelativeType.create(name:"madre")
    RelativeType.create(name:"tutor")

    create_table :relatives do |t|
      t.references :child, null: false
      t.references :relative_type, null: false
      t.string :name, null: false, limit: 255
      t.string :indentifier, null: false, limit: 20
      t.string :phone, null: false, limit: 20
      t.string :mobile, null: false, limit: 20
      t.timestamps
    end

    Relative.create(child_id:1,relative_type_id:2,name:"Juana Gonzalez",indentifier:"1234567890",phone:"2356478",mobile:"0987654321")
    Relative.create(child_id:3,relative_type_id:3,name:"Martha Sanchez",indentifier:"2345678901",phone:"0987653",mobile:"0912345567")
    Relative.create(child_id:2,relative_type_id:1,name:"Pedro Salinas",indentifier:"1890765321",phone:"2356578",mobile:"0947654321")  


    create_table :event_histories do |t|
      t.references :event, null: false
      t.references :participant, null: false, polymorphic: true
      t.boolean :assisted, null: false, default: false
      t.timestamps
    end

    EventHistory.create(event_id:1, participant_id:1, participant_type: 'Child', assisted:true)
    EventHistory.create(event_id:2, participant_id:1, participant_type: 'Relative', assisted:false)
    EventHistory.create(event_id:3, participant_id:2, participant_type: 'Relative', assisted:true)

    create_table :polls do |t|
      t.references :participant, null: false, polymorphic: true
      t.string :code, null: false
      t.date :poll_date, null: false
      t.timestamps
    end

    Poll.create(participant_id:1, participant_type: 'Relative', code:"12345", poll_date:"2016/02/27")
    Poll.create(participant_id:2, participant_type: 'Relative', code:"67890", poll_date:"2016/10/20")
    Poll.create(participant_id:3, participant_type: 'Relative', code:"24680", poll_date:"2016/03/13")

  end

  def down
    drop_table :polls
    drop_table :event_histories
    drop_table :relatives
    drop_table :relative_types
    drop_table :children
    drop_table :child_statuses
    drop_table :diagnostics
    drop_table :hospitals
  end
end
