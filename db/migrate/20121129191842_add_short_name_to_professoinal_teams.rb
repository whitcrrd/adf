class AddShortNameToProfessoinalTeams < ActiveRecord::Migration
  def change
    add_column :professional_teams, :short_name, :string
  end
end
