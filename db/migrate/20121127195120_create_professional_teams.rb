class CreateProfessionalTeams < ActiveRecord::Migration
  def change
    create_table :professional_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
