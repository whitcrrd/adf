class CreateCurrentStats < ActiveRecord::Migration
  def change
    create_table :current_stats do |t|

      t.integer :minutes
      t.string :field_goals
      t.string :three_pointers
      t.string :free_throws
      t.integer :offensive_rebounds
      t.integer :defensive_rebounds
      t.integer :rebounds
      t.integer :assists
      t.integer :steals
      t.integer :blocks
      t.integer :personal_fouls
      t.string :plus_minus
      t.integer :points
      t.integer :athlete_id

      t.timestamps
    end
  end
end
