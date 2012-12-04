class RemoveWinsAndLosses < ActiveRecord::Migration
  def up
    remove_column :users, :wins
    remove_column :users, :losses
  end

  def down
    add_column :users, :wins, :integer, :default => 0
    add_column :users, :wins, :integer, :default => 0
  end
end
