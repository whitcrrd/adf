class AddDateToCurrentStat < ActiveRecord::Migration
  def change
    add_column :current_stats, :game_date, :datetime
  end
end
