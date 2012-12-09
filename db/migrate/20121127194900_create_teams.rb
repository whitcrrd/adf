class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.date :date
      t.integer :user_id
      t.integer :points, :default => 0

      t.timestamps
    end
  end
end
