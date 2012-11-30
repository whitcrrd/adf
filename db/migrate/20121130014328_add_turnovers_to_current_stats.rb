class AddTurnoversToCurrentStats < ActiveRecord::Migration
  def change
    add_column :current_stats, :turnovers, :integer
  end
end
