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

ActiveRecord::Schema.define(version: 20180224202329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blabs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "content", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_blabs_on_user_id"
  end

  create_table "direct_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_direct_auths_on_user_id"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauths", id: :serial, force: :cascade do |t|
    t.string "token", null: false
    t.string "secret", null: false
    t.string "provider"
    t.index ["token"], name: "index_oauths_on_token"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.bigint "domain_id"
    t.bigint "user_id"
    t.integer "specialist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_resources_on_domain_id"
    t.index ["user_id"], name: "index_resources_on_user_id"
  end

  create_table "user_oauth_tokens", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.integer "user_id"
    t.string "token"
    t.string "secret"
    t.string "handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "node_id"
  end

  add_foreign_key "direct_auths", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "resources", "domains"
  add_foreign_key "resources", "users"
end
