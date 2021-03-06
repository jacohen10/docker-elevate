# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160910214900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.integer "restaurant_id"
    t.string  "comment"
  end

  add_index "categories", ["restaurant_id"], name: "index_categories_on_restaurant_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.integer  "year"
    t.string   "email"
    t.integer  "plan"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.string   "verification"
    t.string   "phone"
    t.string   "last_name"
  end

  add_index "customers", ["user_id"], name: "index_customers_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "meals", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "customer_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "status"
    t.string   "food_item"
    t.string   "order_ahead"
    t.string   "comment"
    t.boolean  "payment",       default: false
    t.string   "side"
  end

  add_index "meals", ["customer_id"], name: "index_meals_on_customer_id", using: :btree
  add_index "meals", ["restaurant_id"], name: "index_meals_on_restaurant_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string  "name"
    t.string  "details"
    t.integer "restaurant_id"
    t.integer "category_id"
    t.boolean "available",     default: true
  end

  add_index "menus", ["category_id"], name: "index_menus_on_category_id", using: :btree
  add_index "menus", ["restaurant_id"], name: "index_menus_on_restaurant_id", using: :btree

  create_table "open_times", force: :cascade do |t|
    t.string   "day"
    t.time     "opening"
    t.time     "closing"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "open_times", ["restaurant_id"], name: "index_open_times_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "email"
    t.string   "phone"
    t.string   "menu"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id"
    t.boolean  "order_ahead",           default: false
    t.boolean  "in_restaurant_payment", default: true
    t.boolean  "active",                default: true
    t.integer  "cook_time",             default: 20
  end

  add_index "restaurants", ["user_id"], name: "index_restaurants_on_user_id", using: :btree

  create_table "sides", force: :cascade do |t|
    t.string  "side_item",     default: "none"
    t.string  "details"
    t.integer "category_id"
    t.integer "restaurant_id"
  end

  add_index "sides", ["category_id"], name: "index_sides_on_category_id", using: :btree
  add_index "sides", ["restaurant_id"], name: "index_sides_on_restaurant_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "categories", "restaurants"
  add_foreign_key "customers", "users"
  add_foreign_key "meals", "customers"
  add_foreign_key "meals", "restaurants"
  add_foreign_key "menus", "categories"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "open_times", "restaurants"
  add_foreign_key "restaurants", "users"
  add_foreign_key "sides", "categories"
  add_foreign_key "sides", "restaurants"
end
