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

ActiveRecord::Schema.define(version: 20160925050610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", force: :cascade do |t|
    t.string   "name"
    t.integer  "distance"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.integer  "area"
    t.string   "url"
    t.integer  "average_price"
    t.string   "floor"
    t.string   "build_time"
    t.string   "community"
    t.string   "room_shape"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoppings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subways", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
