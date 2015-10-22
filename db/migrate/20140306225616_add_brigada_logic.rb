# encoding: UTF-8
class AddBrigadaLogic < ActiveRecord::Migration
  def up
    create_table :programs do |t|
      t.string :name, limit: 200, null: false
      t.text :description, limit: 100
      t.timestamps
    end

    juega = Program.create!(name: 'Juega conmigo', description: 'Juega conmigo')
    Program.create!(name: 'Palabras que acompañan', description: 'Palabras que acompañan')
    Program.create!(name: 'Investigación', description: 'Investigación')
    Program.create!(name: 'Socio deportivo', description: 'Socio deportivo')
    Program.create!(name: 'Formación a mamas', description: 'Formación a mamas')
    Program.create!(name: 'Formación a niños', description: 'Formación a niños en artes estéticas')

    create_table :brigades do |t|
      t.references :program, null: false
      t.string :name, limit: 200, null: false
      t.timestamps
    end
    add_column :brigades, :brigade_leader_id, :integer, null: false

    user = User.find(1)

    Brigade.create!(name: 'Petetes', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Endorfinos', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Kebreros', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Apoyefff', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Don Bacho', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Real Mandil', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Cuchurrumines', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Cacariotos', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Las costillas de Mario', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Totes exportados', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Los estudiantes', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Los cotufines', program: juega, brigade_leader_id: user.id)
    Brigade.create!(name: 'Aquiles', program: juega, brigade_leader_id: user.id)

  end

  def down
    drop_table :brigades
    drop_table :programs
  end
end
