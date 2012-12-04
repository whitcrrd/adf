class AddWinsAndLosses < ActiveRecord::Migration
  def up
    add_column :users, :wins, :integer, :default => 0
    add_column :users, :losses, :integer, :default => 0    
  end

  def down
    remove_column :users, :wins
    remove_column :users, :losses
  end
end
