class ChangeGameDate < ActiveRecord::Migration
  def change
    change_column :current_stats, :game_date, :date
  end
end
