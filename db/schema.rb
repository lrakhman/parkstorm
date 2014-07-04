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

ActiveRecord::Schema.define(version: 20140703233341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", primary_key: "gid", force: true do |t|
    t.string  "ward",       limit: 2
    t.integer "ward_num"
    t.integer "sweep"
    t.string  "wardsweep",  limit: 5
    t.string  "ward_secti", limit: 254
    t.string  "month_4",    limit: 254
    t.string  "month_5",    limit: 254
    t.string  "month_6",    limit: 254
    t.string  "month_7",    limit: 254
    t.string  "month_8",    limit: 254
    t.string  "month_9",    limit: 254
    t.string  "month_10",   limit: 254
    t.string  "month_11",   limit: 254
    t.decimal "shape_area"
    t.decimal "shape_len"
    t.spatial "geom",       limit: {:srid=>4326, :type=>"geometry"}
  end

  add_index "regions", ["geom"], :name => "regions_geom_gist", :spatial => true

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
