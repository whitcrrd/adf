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

ActiveRecord::Schema.define(:version => 20121128223310) do

  create_table "athletes", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "professional_team"
    t.string   "position"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "athletes_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "athlete_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "winner_id"
    t.integer  "loser_id"
  end

  add_index "games", ["loser_id"], :name => "index_games_on_loser_id"
  add_index "games", ["winner_id"], :name => "index_games_on_winner_id"

  create_table "teams", :force => true do |t|
    t.date     "date"
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "image_url"
  end

end
