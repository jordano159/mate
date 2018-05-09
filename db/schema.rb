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

ActiveRecord::Schema.define(version: 2018_05_09_162029) do

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
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name"
    t.string "staffable_type"
    t.bigint "staffable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staffable_id", "staffable_type"], name: "index_staffs_on_staffable_id_and_staffable_type"
    t.index ["staffable_type", "staffable_id"], name: "index_staffs_on_staffable_type_and_staffable_id"
  end

end
