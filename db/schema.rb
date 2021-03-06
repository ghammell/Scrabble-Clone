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

ActiveRecord::Schema.define(version: 20141202060330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coordinates", force: true do |t|
    t.integer  "horizontal"
    t.integer  "vertical"
    t.string   "letter",     default: ""
    t.string   "multiplier", default: ""
    t.integer  "multiple",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

  add_index "coordinates", ["game_id"], name: "index_coordinates_on_game_id", using: :btree

  create_table "dictionary_words", force: true do |t|
    t.string   "word"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "coordinate_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
