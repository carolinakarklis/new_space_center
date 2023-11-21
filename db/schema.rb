# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_20_030256) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alien_ships", force: :cascade do |t|
    t.integer "max_crew"
    t.integer "abductions_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_tokens", force: :cascade do |t|
    t.boolean "active", default: true
    t.text "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "load_types", force: :cascade do |t|
    t.integer "name"
    t.integer "weight"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.integer "km_from_earth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rockets", force: :cascade do |t|
    t.bigint "load_type_id", null: false
    t.integer "fuel_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["load_type_id"], name: "index_rockets_on_load_type_id"
  end

  create_table "space_buses", force: :cascade do |t|
    t.integer "max_crew"
    t.integer "fuel_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "space_travels", force: :cascade do |t|
    t.datetime "start_at", precision: nil
    t.integer "duration_in_days"
    t.bigint "planet_id"
    t.bigint "space_vehicle_id"
    t.text "mission_description"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_space_travels_on_planet_id"
    t.index ["space_vehicle_id"], name: "index_space_travels_on_space_vehicle_id"
  end

  create_table "space_vehicles", force: :cascade do |t|
    t.string "name"
    t.integer "km_per_hour"
    t.bigint "agency_id", null: false
    t.string "vehicleable_type", null: false
    t.bigint "vehicleable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_space_vehicles_on_agency_id"
    t.index ["vehicleable_type", "vehicleable_id"], name: "index_space_vehicles_on_vehicleable_type_and_vehicleable_id"
  end

  add_foreign_key "rockets", "load_types"
  add_foreign_key "space_vehicles", "agencies"
end
