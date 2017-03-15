class CreateCollectEmails < ActiveRecord::Migration
  def change
    create_table :collect_emails do |t|
      t.string     :email, limit: 255, null: false
      t.datetime   :created_at, null: false
    end
  end
end
