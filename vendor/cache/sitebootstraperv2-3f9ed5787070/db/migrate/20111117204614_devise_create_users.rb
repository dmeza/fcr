class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :first_name, :limit => 100, :null => false
      t.string :last_name, :limit => 100, :null => false
      t.string :phone, :limit => 20
      t.float :lat
      t.float :lng
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.boolean :is_admin, :default => false
      ## authenticatable
      t.string :email, :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## encryptable
      t.string :password_salt

      ## recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ##  confirmable
      t.string :confirmation_token
      t.string :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email

      ## rememberable
      t.datetime :remember_created_at

      ## trackable
      t.integer :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true

    create_table(:authentications) do |t|
      t.integer :user_id, :null => false
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.string :token, :null => true
      t.string :secret, :null => true
    end
    add_index :authentications, [:provider, :uid], :unique => true, :name => :authentications_provider_uid_index
  end

end
