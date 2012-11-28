class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.date :date
      t.integer :user_id
      t.integer :points

      t.timestamps
    end
  end
end
