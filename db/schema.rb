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

ActiveRecord::Schema.define(version: 2018_05_29_164659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "axes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "head_id"
  end

  create_table "heads", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "axis_id"
  end

  create_table "kids", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.string "last_name"
    t.string "sex"
    t.string "phone"
    t.string "medical"
    t.string "meds"
    t.string "food"
    t.string "city"
    t.string "ken"
    t.string "dad"
    t.string "dad_phone"
    t.string "mom"
    t.string "mom_phone"
    t.string "size"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name"
    t.string "staffable_type"
    t.bigint "staffable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "username"
    t.integer "role"
    t.index ["email"], name: "index_staffs_on_email"
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true
    t.index ["staffable_id", "staffable_type"], name: "index_staffs_on_staffable_id_and_staffable_type"
    t.index ["staffable_type", "staffable_id"], name: "index_staffs_on_staffable_type_and_staffable_id"
    t.index ["username"], name: "index_staffs_on_username", unique: true
  end

end
