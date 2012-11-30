class AddEspnBoxScoreIdToProfessionalTeams < ActiveRecord::Migration
  def change
    add_column :professional_teams, :espn_box_score_id, :string
  end
end
