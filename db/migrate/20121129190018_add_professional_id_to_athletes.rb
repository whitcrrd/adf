class AddProfessionalIdToAthletes < ActiveRecord::Migration
  def change
    add_column  :athletes, :professional_team_id, :integer
  end
end
