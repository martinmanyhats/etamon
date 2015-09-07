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

ActiveRecord::Schema.define(version: 20150726192527) do

  create_table "Mappings_Vars", id: false, force: :cascade do |t|
    t.integer "mapping_id", null: false
    t.integer "var_id",     null: false
  end

  add_index "Mappings_Vars", ["mapping_id", "var_id"], name: "index_Mappings_Vars_on_mapping_id_and_var_id"
  add_index "Mappings_Vars", ["var_id", "mapping_id"], name: "index_Mappings_Vars_on_var_id_and_mapping_id"

  create_table "boilers", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "shortname",                 null: false
    t.string   "ipaddress",                 null: false
    t.integer  "port",       default: 8080, null: false
    t.boolean  "logging",    default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "datalogs", force: :cascade do |t|
    t.integer  "boiler_id"
    t.text     "dataset"
    t.text     "errorset"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "datalogs", ["boiler_id"], name: "index_datalogs_on_boiler_id"

  create_table "mappings", force: :cascade do |t|
    t.integer  "boiler_id",                  null: false
    t.string   "path",                       null: false
    t.string   "uri",                        null: false
    t.string   "datatype",   default: "i",   null: false
    t.boolean  "important",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "vars", force: :cascade do |t|
    t.string   "name"
    t.integer  "boiler_id"
    t.datetime "last_set_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "vars", ["boiler_id"], name: "index_vars_on_boiler_id"

end
