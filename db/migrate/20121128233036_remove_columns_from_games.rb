class RemoveColumnsFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :home_team_id
    remove_column :games, :away_team_id
    remove_column :games, :winner_id
    remove_column :games, :loser_id
  end
end
