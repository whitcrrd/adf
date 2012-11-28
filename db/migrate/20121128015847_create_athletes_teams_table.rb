class CreateAthletesTeamsTable < ActiveRecord::Migration
  def change 
    create_table :athletes_teams do |t|
      t.integer :team_id
      t.integer :athlete_id

      t.timestamps
    end
  end
end
