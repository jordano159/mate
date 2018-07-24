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

ActiveRecord::Schema.define(version: 2018_07_24_063540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer "kid_id"
    t.integer "check_id"
    t.integer "status"
    t.string "cause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cause"], name: "index_attendances_on_cause"
    t.index ["check_id"], name: "index_attendances_on_check_id"
    t.index ["kid_id"], name: "index_attendances_on_kid_id"
    t.index ["status"], name: "index_attendances_on_status"
  end

  create_table "axes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_axes_on_name"
  end

  create_table "checks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.boolean "approved", default: false, null: false
    t.index ["approved"], name: "index_checks_on_approved"
    t.index ["group_id"], name: "index_checks_on_group_id"
    t.index ["name"], name: "index_checks_on_name"
  end

  create_table "events", force: :cascade do |t|
    t.text "content"
    t.bigint "staff_id"
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_events_on_content"
    t.index ["eventable_type", "eventable_id"], name: "index_events_on_eventable_type_and_eventable_id"
    t.index ["staff_id"], name: "index_events_on_staff_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "head_id"
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "heads", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "axis_id"
    t.index ["axis_id"], name: "index_heads_on_axis_id"
    t.index ["name"], name: "index_heads_on_name"
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
    t.string "shabat"
    t.string "parents"
    t.string "swim"
    t.text "exits"
    t.text "comments"
    t.integer "status", default: 0
    t.text "cause"
    t.index ["city"], name: "index_kids_on_city"
    t.index ["comments"], name: "index_kids_on_comments"
    t.index ["dad"], name: "index_kids_on_dad"
    t.index ["dad_phone"], name: "index_kids_on_dad_phone"
    t.index ["exits"], name: "index_kids_on_exits"
    t.index ["food"], name: "index_kids_on_food"
    t.index ["group_id"], name: "index_kids_on_group_id"
    t.index ["ken"], name: "index_kids_on_ken"
    t.index ["last_name"], name: "index_kids_on_last_name"
    t.index ["medical"], name: "index_kids_on_medical"
    t.index ["meds"], name: "index_kids_on_meds"
    t.index ["mom"], name: "index_kids_on_mom"
    t.index ["mom_phone"], name: "index_kids_on_mom_phone"
    t.index ["name"], name: "index_kids_on_name"
    t.index ["parents"], name: "index_kids_on_parents"
    t.index ["phone"], name: "index_kids_on_phone"
    t.index ["sex"], name: "index_kids_on_sex"
    t.index ["shabat"], name: "index_kids_on_shabat"
    t.index ["size"], name: "index_kids_on_size"
    t.index ["swim"], name: "index_kids_on_swim"
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
    t.index ["name"], name: "index_staffs_on_name"
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true
    t.index ["staffable_id", "staffable_type"], name: "index_staffs_on_staffable_id_and_staffable_type"
    t.index ["staffable_type", "staffable_id"], name: "index_staffs_on_staffable_type_and_staffable_id"
    t.index ["username"], name: "index_staffs_on_username", unique: true
  end

  add_foreign_key "events", "staffs"
end
