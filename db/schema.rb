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

ActiveRecord::Schema.define(version: 2019_05_04_104234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.bigint "from_user_id", null: false
    t.bigint "to_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id", "to_user_id"], name: "index_follows_on_from_user_id_and_to_user_id", unique: true
    t.index ["from_user_id"], name: "index_follows_on_from_user_id"
    t.index ["to_user_id"], name: "index_follows_on_to_user_id"
  end

  create_table "sleeps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.datetime "clockin_at"
    t.datetime "clockout_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "date"], name: "index_sleeps_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_sleeps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "auth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth"], name: "index_users_on_auth", unique: true
  end

  add_foreign_key "follows", "users", column: "from_user_id"
  add_foreign_key "follows", "users", column: "to_user_id"
end
