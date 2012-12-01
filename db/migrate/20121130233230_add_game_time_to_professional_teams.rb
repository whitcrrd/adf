class AddGameTimeToProfessionalTeams < ActiveRecord::Migration
  def change
    add_column :professional_teams, :game_time, :float
  end
end
