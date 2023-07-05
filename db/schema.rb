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

ActiveRecord::Schema[7.0].define(version: 2023_07_05_022434) do
  create_table "guests", force: :cascade do |t|
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100
    t.string "email", limit: 100, null: false
    t.string "phone_number", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email"
    t.index ["email"], name: "index_guests_on_email_unique", unique: true
    t.index ["first_name"], name: "index_guests_on_first_name"
    t.index ["last_name"], name: "index_guests_on_last_name"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "code", limit: 100, null: false
    t.integer "guest_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "night_count", null: false
    t.integer "guest_count", null: false
    t.integer "adult_count", null: false
    t.integer "children_count"
    t.integer "infant_count"
    t.string "currency", limit: 100, null: false
    t.decimal "sub_total_price", precision: 10, scale: 2, null: false
    t.decimal "additional_price", precision: 10, scale: 2
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.string "status", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_reservations_on_code"
    t.index ["code"], name: "index_reservations_on_code_unique", unique: true
    t.index ["end_date"], name: "index_reservations_on_end_date"
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["start_date"], name: "index_reservations_on_start_date"
  end

  add_foreign_key "reservations", "guests"
end
