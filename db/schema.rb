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

ActiveRecord::Schema.define(version: 2020_03_08_073940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

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
    t.bigint "mifal_id"
    t.string "hard_name"
    t.index ["mifal_id"], name: "index_axes_on_mifal_id"
    t.index ["name"], name: "index_axes_on_name"
  end

  create_table "buses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mifal_id"
    t.index ["mifal_id"], name: "index_buses_on_mifal_id"
  end

  create_table "checks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.boolean "approved", default: false, null: false
    t.integer "bus_id"
    t.string "date"
    t.index ["approved"], name: "index_checks_on_approved"
    t.index ["group_id"], name: "index_checks_on_group_id"
    t.index ["name"], name: "index_checks_on_name"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "mifal_id"
    t.string "hard_name"
    t.index ["mifal_id"], name: "index_groups_on_mifal_id"
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "heads", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "axis_id"
    t.string "hard_name"
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
    t.string "parent_1"
    t.string "parent_1_phone"
    t.string "parent_2"
    t.string "parent_2_phone"
    t.string "size"
    t.string "shabat"
    t.string "parents"
    t.string "swim"
    t.text "exits"
    t.text "comments"
    t.integer "status"
    t.text "cause"
    t.integer "bus_id"
    t.string "grade"
    t.bigint "taz"
    t.bigint "mifal_id"
    t.integer "last_group"
    t.text "absences_per_month"
    t.text "total_per_month"
    t.string "leave_cause"
    t.index ["city"], name: "index_kids_on_city"
    t.index ["comments"], name: "index_kids_on_comments"
    t.index ["exits"], name: "index_kids_on_exits"
    t.index ["food"], name: "index_kids_on_food"
    t.index ["grade"], name: "index_kids_on_grade"
    t.index ["group_id"], name: "index_kids_on_group_id"
    t.index ["ken"], name: "index_kids_on_ken"
    t.index ["last_name"], name: "index_kids_on_last_name"
    t.index ["medical"], name: "index_kids_on_medical"
    t.index ["meds"], name: "index_kids_on_meds"
    t.index ["mifal_id"], name: "index_kids_on_mifal_id"
    t.index ["name"], name: "index_kids_on_name"
    t.index ["parent_1"], name: "index_kids_on_parent_1"
    t.index ["parent_1_phone"], name: "index_kids_on_parent_1_phone"
    t.index ["parent_2"], name: "index_kids_on_parent_2"
    t.index ["parent_2_phone"], name: "index_kids_on_parent_2_phone"
    t.index ["parents"], name: "index_kids_on_parents"
    t.index ["phone"], name: "index_kids_on_phone"
    t.index ["sex"], name: "index_kids_on_sex"
    t.index ["shabat"], name: "index_kids_on_shabat"
    t.index ["size"], name: "index_kids_on_size"
    t.index ["swim"], name: "index_kids_on_swim"
    t.index ["taz"], name: "index_kids_on_taz"
  end

  create_table "mifals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bus_proposal"
    t.integer "stage"
    t.boolean "has_buses", default: false, null: false
    t.boolean "has_events", default: false, null: false
    t.boolean "has_axes", default: false, null: false
    t.boolean "has_approve", default: false, null: false
    t.boolean "has_late", default: false, null: false
    t.text "group_name"
    t.text "head_name"
    t.text "axis_name"
    t.text "columns"
    t.boolean "checks_num", default: false, null: false
    t.text "guide_name"
    t.text "head_head_name"
    t.string "alert_message"
    t.text "causes"
    t.integer "kids_count", default: 0, null: false
    t.integer "present_kids", default: 0, null: false
    t.text "city_coords"
    t.integer "started_kids", default: 0, null: false
    t.text "check_log"
    t.text "check_names"
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

  add_foreign_key "axes", "mifals"
  add_foreign_key "buses", "mifals"
  add_foreign_key "events", "staffs"
  add_foreign_key "groups", "mifals"
  add_foreign_key "kids", "mifals"
end
