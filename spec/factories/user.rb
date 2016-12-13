FactoryGirl.define do
	  
	factory :user do
	   	first_name 'Usuario'   
	   	last_name 'Admin'
	   	email 'usuario@email.com'
	   	indentifier '0605403040'
	   	city_id 1
	   	phone '032964983'
	   	birth_date Date.today
	   	password 'password'
	   	encrypted_password 'password'     
  		password_salt 'password'
  		is_admin true
	end

end


  # create_table "users", force: :cascade do |t|
  #   t.string   "first_name",                limit: 100,                   null: false
  #   t.string   "last_name",                 limit: 100,                   null: false
  #   t.string   "phone",                     limit: 20
  #   t.float    "lat",                       limit: 24
  #   t.float    "lng",                       limit: 24
  #   t.string   "photo_file_name",           limit: 255
  #   t.string   "photo_content_type",        limit: 255
  #   t.integer  "photo_file_size",           limit: 4
  #   t.boolean  "is_admin",                                default: false
  #   t.string   "email",                     limit: 255,   default: "",    null: false
  #   t.string   "encrypted_password",        limit: 255,   default: "",    null: false
  #   t.string   "password_salt",             limit: 255
  #   t.string   "reset_password_token",      limit: 255
  #   t.datetime "reset_password_sent_at"
  #   t.string   "confirmation_token",        limit: 255
  #   t.string   "confirmed_at",              limit: 255
  #   t.datetime "confirmation_sent_at"
  #   t.string   "unconfirmed_email",         limit: 255
  #   t.datetime "remember_created_at"
  #   t.integer  "sign_in_count",             limit: 4,     default: 0
  #   t.datetime "current_sign_in_at"
  #   t.datetime "last_sign_in_at"
  #   t.string   "current_sign_in_ip",        limit: 255
  #   t.string   "last_sign_in_ip",           limit: 255
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.boolean  "has_induction",                           default: false
  #   t.date     "birth_date"
  #   t.string   "indentifier",               limit: 20
  #   t.boolean  "contact_me"
  #   t.boolean  "has_institution_induction"
  #   t.string   "mobile",                    limit: 30
  #   t.text     "motivation",                limit: 65535
  #   t.integer  "brigade_id",                limit: 4
  #   t.integer  "city_id",                   limit: 4
  # end