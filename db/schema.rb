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

ActiveRecord::Schema.define(version: 20181203232320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "email",                         null: false
    t.string   "password",                      null: false
    t.string   "usertype",                      null: false
    t.string   "access",                        null: false
    t.text     "session_token",                 null: false
    t.text     "reset_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size",    limit: 8
    t.datetime "avatar_updated_at"
  end

  add_index "authentications", ["session_token"], name: "index_authentications_on_session_token", using: :btree

  create_table "categoricalformattributes", force: :cascade do |t|
    t.integer  "formattributes_id"
    t.string   "option"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "dataentries", force: :cascade do |t|
    t.string   "firstname",          null: false
    t.string   "lastname"
    t.string   "profile",            null: false
    t.string   "institution",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authentications_id"
  end

  add_index "dataentries", ["authentications_id"], name: "index_dataentries_on_authentications_id", using: :btree

  create_table "formattributes", force: :cascade do |t|
    t.string   "column_name"
    t.string   "column_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forms_id"
    t.boolean  "categorical", default: false
  end

  add_index "formattributes", ["forms_id"], name: "index_formattributes_on_forms_id", using: :btree

  create_table "forms", force: :cascade do |t|
    t.string   "form_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "projects_id"
    t.boolean  "archive",     default: false
  end

  add_index "forms", ["projects_id"], name: "index_forms_on_projects_id", using: :btree

  create_table "formsaccesses", force: :cascade do |t|
    t.integer "forms_id"
    t.integer "dataentries_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_name"
    t.string   "research_group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "researchers_id"
    t.boolean  "archive",        default: false
  end

  add_index "projects", ["researchers_id"], name: "index_projects_on_researchers_id", using: :btree

  create_table "researchers", force: :cascade do |t|
    t.string   "firstname",          null: false
    t.string   "lastname",           null: false
    t.string   "researchgroup",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authentications_id"
  end

  add_index "researchers", ["authentications_id"], name: "index_researchers_on_authentications_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forms_id"
    t.jsonb    "jsondata"
  end

  add_index "results", ["forms_id"], name: "index_results_on_forms_id", using: :btree

  create_table "resultsstagings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forms_id"
    t.boolean  "updateneeded", default: false
    t.jsonb    "jsondata"
  end

  add_index "resultsstagings", ["forms_id"], name: "index_resultsstagings_on_forms_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end
