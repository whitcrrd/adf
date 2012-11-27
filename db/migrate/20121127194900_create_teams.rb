class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
