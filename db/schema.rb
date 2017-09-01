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

ActiveRecord::Schema.define(version: 20161027095326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "buses", ["latitude"], name: "index_buses_on_latitude", using: :btree
  add_index "buses", ["longitude"], name: "index_buses_on_longitude", using: :btree
  add_index "buses", ["name"], name: "index_buses_on_name", using: :btree

  create_table "buses_houses", force: :cascade do |t|
    t.integer  "bus_id"
    t.integer  "house_id"
    t.integer  "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hospitals", ["latitude"], name: "index_hospitals_on_latitude", using: :btree
  add_index "hospitals", ["longitude"], name: "index_hospitals_on_longitude", using: :btree
  add_index "hospitals", ["name"], name: "index_hospitals_on_name", using: :btree

  create_table "hospitals_houses", force: :cascade do |t|
    t.integer  "hospital_id"
    t.integer  "house_id"
    t.integer  "distance"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "houses", force: :cascade do |t|
    t.integer  "area"
    t.string   "url"
    t.integer  "average_price"
    t.string   "floor"
    t.integer  "build_time"
    t.string   "community"
    t.string   "room_shape"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "schools", ["latitude"], name: "index_schools_on_latitude", using: :btree
  add_index "schools", ["longitude"], name: "index_schools_on_longitude", using: :btree
  add_index "schools", ["name"], name: "index_schools_on_name", using: :btree

  create_table "schools_houses", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "house_id"
    t.integer  "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shops", ["latitude"], name: "index_shops_on_latitude", using: :btree
  add_index "shops", ["longitude"], name: "index_shops_on_longitude", using: :btree
  add_index "shops", ["name"], name: "index_shops_on_name", using: :btree

  create_table "shops_houses", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "house_id"
    t.integer  "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subways", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subways", ["latitude"], name: "index_subways_on_latitude", using: :btree
  add_index "subways", ["longitude"], name: "index_subways_on_longitude", using: :btree
  add_index "subways", ["name"], name: "index_subways_on_name", using: :btree

  create_table "subways_houses", force: :cascade do |t|
    t.integer  "subway_id"
    t.integer  "house_id"
    t.integer  "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "works", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "works", ["latitude"], name: "index_works_on_latitude", using: :btree
  add_index "works", ["longitude"], name: "index_works_on_longitude", using: :btree
  add_index "works", ["name"], name: "index_works_on_name", using: :btree

  create_table "works_houses", force: :cascade do |t|
    t.integer  "work_id"
    t.integer  "house_id"
    t.integer  "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
