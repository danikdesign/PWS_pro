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

ActiveRecord::Schema[7.0].define(version: 2023_04_23_120217) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.string "purifier_brand"
    t.integer "purifier_stages"
    t.integer "purifier_tank"
    t.boolean "purifier_pump"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installations", force: :cascade do |t|
    t.date "date"
    t.float "pressure"
    t.integer "in_tds"
    t.integer "out_tds"
    t.text "notes"
    t.boolean "status"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_installations_on_client_id"
  end

  create_table "passwordless_sessions", force: :cascade do |t|
    t.string "authenticatable_type"
    t.bigint "authenticatable_id"
    t.datetime "timeout_at", precision: nil, null: false
    t.datetime "expires_at", precision: nil, null: false
    t.datetime "claimed_at", precision: nil
    t.text "user_agent", null: false
    t.string "remote_addr", null: false
    t.string "token", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["authenticatable_type", "authenticatable_id"], name: "authenticatable"
  end

  create_table "purifier_brands", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purifier_parts", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purifier_stages", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purifier_tanks", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_purifier_parts", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "purifier_part_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purifier_part_id"], name: "index_service_purifier_parts_on_purifier_part_id"
    t.index ["service_id"], name: "index_service_purifier_parts_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.date "date"
    t.float "pressure"
    t.integer "in_tds"
    t.integer "out_tds_before"
    t.integer "out_tds_after"
    t.boolean "status"
    t.bigint "client_id", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_services_on_client_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "datetime"
    t.text "notes"
    t.string "ticketable_type", null: false
    t.bigint "ticketable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticketable_type", "ticketable_id"], name: "index_tickets_on_ticketable"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "telegram_id"
  end

  add_foreign_key "installations", "clients"
  add_foreign_key "service_purifier_parts", "purifier_parts"
  add_foreign_key "service_purifier_parts", "services"
  add_foreign_key "services", "clients"
end
