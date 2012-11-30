class CreateProfessionalTeams < ActiveRecord::Migration
  def change
    create_table :professional_teams do |t|
      t.string :name
      t.boolean :playing_today, :default => false

      t.timestamps
    end
  end
end
