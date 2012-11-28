class AddWinnerAndLoserToGames < ActiveRecord::Migration
  def change
    add_column :games, :winner_id, :integer
    add_column :games, :loser_id, :integer
    add_index :games, :winner_id
    add_index :games, :loser_id
  end
end
