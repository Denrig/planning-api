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

ActiveRecord::Schema.define(version: 2022_03_16_093826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "room_attendances", force: :cascade do |t|
    t.integer "role"
    t.uuid "room_id"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_room_attendances_on_room_id"
    t.index ["user_id"], name: "index_room_attendances_on_user_id"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "players_count"
    t.boolean "active", default: true
    t.boolean "is_private", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.index ["code"], name: "index_rooms_on_code", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "text"
    t.uuid "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "result"
    t.boolean "is_current", default: false, null: false
    t.text "description"
    t.string "status"
    t.integer "isssue_type"
    t.index ["room_id"], name: "index_tasks_on_room_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "character_image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "task_id"
    t.string "vote"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_votes_on_task_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "room_attendances", "rooms"
  add_foreign_key "room_attendances", "users"
  add_foreign_key "tasks", "rooms"
  add_foreign_key "votes", "tasks"
  add_foreign_key "votes", "users"
end
