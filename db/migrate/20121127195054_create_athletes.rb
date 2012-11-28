class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :first_name
      t.string :last_name
      t.string :professional_team
      t.string :position

      t.timestamps
    end
  end
end
