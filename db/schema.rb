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

ActiveRecord::Schema.define(:version => 20121130230648) do

  create_table "athletes", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "professional_team"
    t.string   "position"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "full_name"
    t.integer  "professional_team_id"
  end

  create_table "athletes_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "athlete_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "current_stats", :force => true do |t|
    t.integer  "minutes"
    t.string   "field_goals"
    t.string   "three_pointers"
    t.string   "free_throws"
    t.integer  "offensive_rebounds"
    t.integer  "defensive_rebounds"
    t.integer  "rebounds"
    t.integer  "assists"
    t.integer  "steals"
    t.integer  "blocks"
    t.integer  "personal_fouls"
    t.string   "plus_minus"
    t.integer  "points"
    t.integer  "athlete_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "turnovers"
    t.date     "game_date"
  end

  create_table "games", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "winner_id"
    t.integer  "loser_id"
  end

  add_index "games", ["loser_id"], :name => "index_games_on_loser_id"
  add_index "games", ["winner_id"], :name => "index_games_on_winner_id"

  create_table "professional_teams", :force => true do |t|
    t.string   "name"
    t.boolean  "playing_today",     :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "short_name"
    t.string   "espn_box_score_id"
  end

  create_table "season_averages", :force => true do |t|
    t.integer  "games"
    t.integer  "games_started"
    t.float    "minutes"
    t.float    "field_goals"
    t.float    "three_pointers"
    t.float    "free_throws"
    t.float    "offensive_rebounds"
    t.float    "defensive_rebounds"
    t.float    "rebounds"
    t.float    "assists"
    t.float    "steals"
    t.float    "blocks"
    t.float    "turnovers"
    t.float    "personal_fouls"
    t.float    "points"
    t.integer  "athlete_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "teams", :force => true do |t|
    t.date     "date"
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.integer  "game_id"
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
