# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150902214643) do

  create_table "areas", :force => true do |t|
    t.string   "name",       :limit => 200,                     :null => false
    t.string   "color",      :limit => 20,  :default => "blue", :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer "user_id",  :null => false
    t.string  "provider", :null => false
    t.string  "uid",      :null => false
    t.string  "token"
    t.string  "secret"
  end

  add_index "authentications", ["provider", "uid"], :name => "authentications_provider_uid_index", :unique => true

  create_table "brigades", :force => true do |t|
    t.integer  "program_id",                       :null => false
    t.string   "name",              :limit => 200, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "brigade_leader_id",                :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :limit => 200, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "event_images", :force => true do |t|
    t.integer  "event_id",           :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "name",               :limit => 200,                    :null => false
    t.boolean  "requires_inception",                :default => true
    t.boolean  "is_inception",                      :default => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.boolean  "has_limit",                         :default => false, :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name",            :limit => 200,                       :null => false
    t.text     "description",     :limit => 255
    t.integer  "spaces",                         :default => 1,        :null => false
    t.integer  "used",                           :default => 0,        :null => false
    t.datetime "event_date",                                           :null => false
    t.string   "place",                                                :null => false
    t.string   "state",                          :default => "Activo", :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "event_type_id",                                        :null => false
    t.integer  "responsable_id"
    t.integer  "city_id"
    t.boolean  "requires_adult",                 :default => false
    t.integer  "area_id",                                              :null => false
    t.string   "role"
    t.datetime "activation_date",                                      :null => false
    t.integer  "brigade_id"
    t.time     "end_time"
  end

  create_table "events_users", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.integer  "event_id",                        :null => false
    t.datetime "created_at"
    t.boolean  "is_brigadist", :default => false, :null => false
  end

  create_table "programs", :force => true do |t|
    t.string   "name",        :limit => 200, :null => false
    t.text     "description", :limit => 255
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",                :limit => 100,                    :null => false
    t.string   "last_name",                 :limit => 100,                    :null => false
    t.string   "phone",                     :limit => 20
    t.float    "lat"
    t.float    "lng"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.boolean  "is_admin",                                 :default => false
    t.string   "email",                                    :default => "",    :null => false
    t.string   "encrypted_password",                       :default => "",    :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.string   "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                            :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.boolean  "has_induction",                            :default => false
    t.date     "birth_date"
    t.string   "indentifier",               :limit => 20
    t.boolean  "contact_me"
    t.boolean  "has_institution_induction"
    t.string   "mobile",                    :limit => 30
    t.text     "motivation"
    t.integer  "brigade_id"
    t.integer  "city_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
