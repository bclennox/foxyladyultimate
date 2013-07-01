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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130529023505) do

  create_table "games", :force => true do |t|
    t.string   "location"
    t.datetime "starts_at"
    t.boolean  "canceled",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "access_token"
    t.datetime "deleted_at"
  end

  create_table "queue_classic_jobs", :force => true do |t|
    t.string   "q_name"
    t.string   "method"
    t.text     "args"
    t.datetime "locked_at"
  end

  add_index "queue_classic_jobs", ["q_name", "id"], :name => "idx_qc_on_name_only_unlocked"

  create_table "responses", :force => true do |t|
    t.integer  "player_id"
    t.integer  "game_id"
    t.boolean  "playing",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string   "day"
    t.string   "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "location"
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
  end

end
