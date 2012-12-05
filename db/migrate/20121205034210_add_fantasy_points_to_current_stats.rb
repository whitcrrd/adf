class AddFantasyPointsToCurrentStats < ActiveRecord::Migration
  def up
    add_column :current_stats, :fantasy_points, :integer, :default => 0
  end
  
  def down
    remove_column :current_stats, :fantasy_points
  end
end
