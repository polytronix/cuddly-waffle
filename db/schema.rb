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

ActiveRecord::Schema.define(version: 20170413162721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_stat_statements"

  create_table "dimensions", force: :cascade do |t|
    t.decimal "width", default: "0.0", null: false
    t.decimal "length", default: "0.0", null: false
    t.integer "film_id", null: false
    t.index ["film_id"], name: "index_dimensions_on_film_id"
  end

  create_table "film_movements", force: :cascade do |t|
    t.string "from_phase", null: false
    t.string "to_phase", null: false
    t.decimal "width", default: "0.0", null: false
    t.decimal "length", default: "0.0", null: false
    t.string "actor", null: false
    t.integer "film_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tenant_code", null: false
    t.index ["created_at"], name: "index_film_movements_on_created_at"
    t.index ["film_id"], name: "index_film_movements_on_film_id"
    t.index ["from_phase"], name: "index_film_movements_on_from_phase"
    t.index ["tenant_code"], name: "index_film_movements_on_tenant_code"
    t.index ["to_phase"], name: "index_film_movements_on_to_phase"
  end

  create_table "films", force: :cascade do |t|
    t.integer "master_film_id", null: false
    t.text "note"
    t.string "shelf"
    t.boolean "deleted", default: false
    t.integer "sales_order_id"
    t.integer "order_fill_count", default: 1, null: false
    t.string "tenant_code", null: false
    t.string "serial", null: false
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

  create_table "job_dates", force: :cascade do |t|
    t.bigint "job_order_id", null: false
    t.string "step", null: false
    t.date "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false, null: false
    t.index ["job_order_id"], name: "index_job_dates_on_job_order_id"
    t.index ["value"], name: "index_job_dates_on_value"
  end

  create_table "job_orders", force: :cascade do |t|
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

  create_table "line_items", force: :cascade do |t|
    t.integer "sales_order_id", null: false
    t.decimal "custom_width", null: false
    t.decimal "custom_length", null: false
    t.integer "quantity", null: false
    t.string "wire_length"
    t.string "busbar_type"
    t.text "note"
    t.string "product_type", null: false
    t.index ["sales_order_id"], name: "index_line_items_on_sales_order_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "code", null: false
    t.decimal "yield_constant", null: false
    t.string "tenant_code", null: false
    t.index ["tenant_code"], name: "index_machines_on_tenant_code"
  end

  create_table "master_films", force: :cascade do |t|
    t.string "serial", null: false
    t.string "formula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "mix_mass"
    t.string "film_code_top"
    t.string "thinky_code"
    t.integer "machine_id"
    t.decimal "effective_width", default: "0.0", null: false
    t.decimal "effective_length", default: "0.0", null: false
    t.string "operator"
    t.string "chemist"
    t.text "note"
    t.hstore "defects", default: {}, null: false
    t.string "tenant_code", null: false
    t.decimal "micrometer_left"
    t.decimal "micrometer_right"
    t.decimal "run_speed"
    t.string "inspector"
    t.date "serial_date", default: "2021-04-16", null: false
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

  create_table "sales_orders", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer"
    t.date "due_date", null: false
    t.date "release_date", null: false
    t.string "ship_to"
    t.date "ship_date"
    t.text "note"
    t.string "tenant_code", null: false
    t.integer "status", default: 0, null: false
    t.index ["due_date"], name: "index_sales_orders_on_due_date"
    t.index ["release_date"], name: "index_sales_orders_on_release_date"
    t.index ["ship_date"], name: "index_sales_orders_on_ship_date"
    t.index ["status"], name: "index_sales_orders_on_status"
    t.index ["tenant_code"], name: "index_sales_orders_on_tenant_code"
  end

  create_table "solder_measurements", force: :cascade do |t|
    t.decimal "height1", default: "0.0", null: false
    t.decimal "height2", default: "0.0", null: false
    t.bigint "film_id", null: false
    t.index ["film_id"], name: "index_solder_measurements_on_film_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name", null: false
    t.boolean "chemist", default: false
    t.boolean "operator", default: false
    t.string "password_digest", null: false
    t.integer "role_level", default: 0, null: false
    t.string "tenant_code", null: false
    t.boolean "inspector", default: false, null: false
    t.index ["tenant_code"], name: "index_users_on_tenant_code"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "job_dates", "job_orders"
end
