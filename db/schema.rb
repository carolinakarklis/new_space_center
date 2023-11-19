# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_11_19_221313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "load_types", force: :cascade do |t|
    t.integer "name"
    t.integer "weight"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.integer "km_from_earth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rockets", force: :cascade do |t|
    t.bigint "load_type_id", null: false
    t.integer "fuel_days"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["load_type_id"], name: "index_rockets_on_load_type_id"
  end

  create_table "space_vehicles", force: :cascade do |t|
    t.string "name"
    t.integer "km_per_hour"
    t.bigint "agency_id", null: false
    t.string "vehicleable_type", null: false
    t.bigint "vehicleable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agency_id"], name: "index_space_vehicles_on_agency_id"
    t.index ["vehicleable_type", "vehicleable_id"], name: "index_space_vehicles_on_vehicleable_type_and_vehicleable_id"
  end

  add_foreign_key "rockets", "load_types"
  add_foreign_key "space_vehicles", "agencies"
end
