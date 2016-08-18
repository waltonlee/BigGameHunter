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

ActiveRecord::Schema.define(version: 20160818034350) do

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "gametype_id"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "need_players", default: false
    t.integer  "need_count",   default: 0
    t.string   "description"
    t.integer  "count",        default: 0
  end

  add_index "games", ["gametype_id"], name: "index_games_on_gametype_id"
  add_index "games", ["start", "created_at"], name: "index_games_on_start_and_created_at"
  add_index "games", ["user_id"], name: "index_games_on_user_id"

  create_table "games_users", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "user_id", null: false
  end

  add_index "games_users", ["game_id", "user_id"], name: "attended_to_attendees", unique: true
  add_index "games_users", ["user_id", "game_id"], name: "attendees_to_attended", unique: true

  create_table "gametypes", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gametypes_users", id: false, force: :cascade do |t|
    t.integer "gametype_id", null: false
    t.integer "user_id",     null: false
  end

  add_index "gametypes_users", ["gametype_id", "user_id"], name: "index_gametypes_users_on_gametype_id_and_user_id"
  add_index "gametypes_users", ["user_id", "gametype_id"], name: "index_gametypes_users_on_user_id_and_gametype_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",                              default: "",    null: false
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "authentication_token",   limit: 30
    t.boolean  "admin",                             default: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
