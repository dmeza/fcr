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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170308163323) do

  create_table "areas", force: :cascade do |t|
    t.string   "name",       limit: 200,                  null: false
    t.string   "color",      limit: 20,  default: "blue", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id",  limit: 4,   null: false
    t.string  "provider", limit: 255, null: false
    t.string  "uid",      limit: 255, null: false
    t.string  "token",    limit: 255
    t.string  "secret",   limit: 255
  end

  add_index "authentications", ["provider", "uid"], name: "authentications_provider_uid_index", unique: true, using: :btree

  create_table "brigades", force: :cascade do |t|
    t.integer  "program_id",        limit: 4,   null: false
    t.string   "name",              limit: 200, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brigade_leader_id", limit: 4,   null: false
  end

  create_table "child_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "children", force: :cascade do |t|
    t.integer  "hospital_id",       limit: 4,   null: false
    t.integer  "diagnostic_id",     limit: 4,   null: false
    t.integer  "child_status_id",   limit: 4,   null: false
    t.integer  "city_id",           limit: 4,   null: false
    t.string   "name",              limit: 255, null: false
    t.date     "birth_date",                    null: false
    t.string   "genere",            limit: 50,  null: false
    t.string   "dream",             limit: 500
    t.string   "address",           limit: 300
    t.integer  "siblings_over_18",  limit: 4
    t.integer  "siblings_under_18", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 200, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collect_places", force: :cascade do |t|
    t.integer  "city_id",    limit: 4,   null: false
    t.string   "name",       limit: 400, null: false
    t.string   "address",    limit: 400, null: false
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collect_year_place_volunteers", force: :cascade do |t|
    t.integer  "collect_year_place_id", limit: 4,                         null: false
    t.string   "first_name",            limit: 100,                       null: false
    t.string   "last_name",             limit: 100,                       null: false
    t.string   "phone",                 limit: 20
    t.string   "email",                 limit: 255,                       null: false
    t.string   "state",                 limit: 20,  default: "Pendiente", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collect_year_places", force: :cascade do |t|
    t.integer  "collect_place_id", limit: 4,                         null: false
    t.integer  "collect_year_id",  limit: 4,                         null: false
    t.integer  "place_leader_id",  limit: 4
    t.integer  "volunteer_count",  limit: 2,  default: 0,            null: false
    t.string   "state",            limit: 20, default: "Disponible", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collect_years", force: :cascade do |t|
    t.integer "year",       limit: 4, null: false
    t.date    "event_date",           null: false
  end

  create_table "diagnostics", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_histories", force: :cascade do |t|
    t.integer  "event_id",         limit: 4,                   null: false
    t.integer  "participant_id",   limit: 4,                   null: false
    t.string   "participant_type", limit: 255,                 null: false
    t.boolean  "assisted",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_images", force: :cascade do |t|
    t.integer  "event_id",           limit: 4,   null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "name",               limit: 200,                 null: false
    t.boolean  "requires_inception",             default: true
    t.boolean  "is_inception",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_limit",                      default: false, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",            limit: 200,                    null: false
    t.text     "description",     limit: 255
    t.integer  "spaces",          limit: 4,   default: 1,        null: false
    t.integer  "used",            limit: 4,   default: 0,        null: false
    t.datetime "event_date",                                     null: false
    t.string   "place",           limit: 255,                    null: false
    t.string   "state",           limit: 255, default: "Activo", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_type_id",   limit: 4,                      null: false
    t.integer  "responsable_id",  limit: 4
    t.integer  "city_id",         limit: 4
    t.boolean  "requires_adult",              default: false
    t.integer  "area_id",         limit: 4,                      null: false
    t.string   "role",            limit: 255
    t.datetime "activation_date",                                null: false
    t.integer  "brigade_id",      limit: 4
    t.time     "end_time"
  end

  create_table "events_users", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,                 null: false
    t.integer  "event_id",     limit: 4,                 null: false
    t.datetime "created_at"
    t.boolean  "is_brigadist",           default: false, null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.integer  "city_id",    limit: 4,   null: false
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", force: :cascade do |t|
    t.integer  "participant_id",   limit: 4,   null: false
    t.string   "participant_type", limit: 255, null: false
    t.string   "code",             limit: 255, null: false
    t.date     "poll_date",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name",        limit: 200, null: false
    t.text     "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relative_types", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relatives", force: :cascade do |t|
    t.integer  "child_id",         limit: 4,   null: false
    t.integer  "relative_type_id", limit: 4,   null: false
    t.string   "name",             limit: 255, null: false
    t.string   "indentifier",      limit: 20,  null: false
    t.string   "phone",            limit: 20,  null: false
    t.string   "mobile",           limit: 20,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                limit: 100,                          null: false
    t.string   "last_name",                 limit: 100,                          null: false
    t.string   "phone",                     limit: 20
    t.float    "lat",                       limit: 24
    t.float    "lng",                       limit: 24
    t.string   "photo_file_name",           limit: 255
    t.string   "photo_content_type",        limit: 255
    t.integer  "photo_file_size",           limit: 4
    t.boolean  "is_admin",                                default: false
    t.string   "email",                     limit: 255,   default: "",           null: false
    t.string   "encrypted_password",        limit: 255,   default: "",           null: false
    t.string   "password_salt",             limit: 255
    t.string   "reset_password_token",      limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token",        limit: 255
    t.string   "confirmed_at",              limit: 255
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",         limit: 255
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             limit: 4,     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",        limit: 255
    t.string   "last_sign_in_ip",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_induction",                           default: false
    t.date     "birth_date"
    t.string   "indentifier",               limit: 20
    t.boolean  "contact_me"
    t.boolean  "has_institution_induction"
    t.string   "mobile",                    limit: 30
    t.text     "motivation",                limit: 65535
    t.integer  "brigade_id",                limit: 4
    t.integer  "city_id",                   limit: 4
    t.string   "user_type",                 limit: 50,    default: "voluntario", null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
