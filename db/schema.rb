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

ActiveRecord::Schema.define(version: 2023_03_10_184852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "dimensions", id: :serial, force: :cascade do |t|
    t.decimal "width", default: "0.0", null: false
    t.decimal "length", default: "0.0", null: false
    t.integer "film_id", null: false
    t.index ["film_id"], name: "index_dimensions_on_film_id"
  end

  create_table "film_movements", id: :serial, force: :cascade do |t|
    t.string "from_phase", limit: 255, null: false
    t.string "to_phase", limit: 255, null: false
    t.decimal "width", default: "0.0", null: false
    t.decimal "length", default: "0.0", null: false
    t.string "actor", limit: 255, null: false
    t.integer "film_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "tenant_code", limit: 255, null: false
    t.index ["created_at"], name: "index_film_movements_on_created_at"
    t.index ["film_id"], name: "index_film_movements_on_film_id"
    t.index ["from_phase"], name: "index_film_movements_on_from_phase"
    t.index ["tenant_code"], name: "index_film_movements_on_tenant_code"
    t.index ["to_phase"], name: "index_film_movements_on_to_phase"
  end

  create_table "films", id: :serial, force: :cascade do |t|
    t.integer "master_film_id", null: false
    t.text "note"
    t.string "shelf", limit: 255
    t.boolean "deleted", default: false
    t.integer "sales_order_id"
    t.integer "order_fill_count", default: 1, null: false
    t.string "tenant_code", limit: 255, null: false
    t.string "serial", limit: 255, null: false
    t.decimal "area", default: "0.0", null: false
    t.integer "phase", default: 0, null: false
    t.index ["area"], name: "index_films_on_area"
    t.index ["deleted"], name: "index_films_on_deleted"
    t.index ["master_film_id"], name: "index_films_on_master_film_id"
    t.index ["phase"], name: "index_films_on_phase"
    t.index ["sales_order_id"], name: "index_films_on_sales_order_id"
    t.index ["serial"], name: "index_films_on_serial"
    t.index ["tenant_code"], name: "index_films_on_tenant_code"
  end

  create_table "job_dates", id: :serial, force: :cascade do |t|
    t.integer "job_order_id", null: false
    t.string "step", null: false
    t.date "value", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "completed", default: false, null: false
    t.index ["job_order_id"], name: "index_job_dates_on_job_order_id"
    t.index ["value"], name: "index_job_dates_on_value"
  end

  create_table "job_orders", id: :serial, force: :cascade do |t|
    t.string "serial", default: "", null: false
    t.string "quantity", default: "", null: false
    t.string "part_number", default: "", null: false
    t.string "run_number", default: "", null: false
    t.string "note", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "priority", default: "", null: false
    t.index ["serial"], name: "index_job_orders_on_serial", unique: true
  end

  create_table "line_items", id: :serial, force: :cascade do |t|
    t.integer "sales_order_id", null: false
    t.decimal "custom_width", null: false
    t.decimal "custom_length", null: false
    t.integer "quantity", null: false
    t.string "wire_length", limit: 255
    t.string "busbar_type", limit: 255
    t.text "note"
    t.string "product_type", limit: 255, null: false
    t.index ["sales_order_id"], name: "index_line_items_on_sales_order_id"
  end

  create_table "machines", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.decimal "yield_constant", null: false
    t.string "tenant_code", limit: 255, null: false
    t.index ["tenant_code"], name: "index_machines_on_tenant_code"
  end

  create_table "master_films", id: :serial, force: :cascade do |t|
    t.string "serial", limit: 255, null: false
    t.string "formula", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "mix_mass"
    t.string "film_code_top", limit: 255
    t.string "thinky_code", limit: 255
    t.integer "machine_id"
    t.decimal "effective_width", default: "0.0", null: false
    t.decimal "effective_length", default: "0.0", null: false
    t.string "operator", limit: 255
    t.string "chemist", limit: 255
    t.text "note"
    t.hstore "defects", default: {}, null: false
    t.string "tenant_code", limit: 255, null: false
    t.decimal "micrometer_left"
    t.decimal "micrometer_right"
    t.decimal "run_speed"
    t.string "inspector", limit: 255
    t.date "serial_date", default: "2014-05-15", null: false
    t.integer "function", default: 0, null: false
    t.decimal "yield"
    t.decimal "temperature"
    t.decimal "humidity"
    t.decimal "b_value"
    t.decimal "wep_uv_on"
    t.decimal "wep_visible_on"
    t.decimal "wep_ir_on"
    t.decimal "wep_uv_off"
    t.decimal "wep_visible_off"
    t.decimal "wep_ir_off"
    t.decimal "haze"
    t.string "Supplier_ID"
    t.string "string"
    t.index ["defects"], name: "master_films_defects", using: :gin
    t.index ["machine_id"], name: "index_master_films_on_machine_id"
    t.index ["serial"], name: "index_master_films_on_serial"
    t.index ["tenant_code"], name: "index_master_films_on_tenant_code"
  end

  create_table "sales_orders", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "customer", limit: 255
    t.date "due_date", null: false
    t.date "release_date", null: false
    t.string "ship_to", limit: 255
    t.date "ship_date"
    t.text "note"
    t.string "tenant_code", limit: 255, null: false
    t.integer "status", default: 0, null: false
    t.index ["due_date"], name: "index_sales_orders_on_due_date"
    t.index ["release_date"], name: "index_sales_orders_on_release_date"
    t.index ["ship_date"], name: "index_sales_orders_on_ship_date"
    t.index ["status"], name: "index_sales_orders_on_status"
    t.index ["tenant_code"], name: "index_sales_orders_on_tenant_code"
  end

  create_table "solder_measurements", id: :serial, force: :cascade do |t|
    t.decimal "height1", default: "0.0", null: false
    t.decimal "height2", default: "0.0", null: false
    t.integer "film_id", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "full_name", limit: 255, null: false
    t.boolean "chemist", default: false
    t.boolean "operator", default: false
    t.string "password_digest", limit: 255, null: false
    t.integer "role_level", default: 0, null: false
    t.string "tenant_code", limit: 255, null: false
    t.boolean "inspector", default: false, null: false
    t.index ["tenant_code"], name: "index_users_on_tenant_code"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "job_dates", "job_orders"
end
