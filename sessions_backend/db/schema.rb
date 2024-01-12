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

ActiveRecord::Schema.define(version: 2024_01_11_192038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "client_hash_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_hash_id"], name: "index_clients_on_client_hash_id", unique: true
  end

  create_table "coaches", force: :cascade do |t|
    t.string "name", null: false
    t.string "coach_hash_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_hash_id"], name: "index_coaches_on_coach_hash_id", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "start", null: false
    t.integer "duration", null: false
    t.string "coach_hash_id", null: false
    t.string "client_hash_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "sessions", "clients", column: "client_hash_id", primary_key: "client_hash_id"
  add_foreign_key "sessions", "coaches", column: "coach_hash_id", primary_key: "coach_hash_id"
end
