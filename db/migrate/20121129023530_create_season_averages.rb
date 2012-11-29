class CreateSeasonAverages < ActiveRecord::Migration
  def change
    create_table :season_averages do |t|
      t.integer :games
      t.integer :games_started
      t.float :minutes
      t.float :field_goals
      t.float :three_pointers
      t.float :free_throws
      t.float :offensive_rebounds
      t.float :defensive_rebounds
      t.float :rebounds
      t.float :assists
      t.float :steals
      t.float :blocks
      t.float :turnovers
      t.float :personal_fouls
      t.float :points
      t.integer :athlete_id

      t.timestamps
    end
  end
end
