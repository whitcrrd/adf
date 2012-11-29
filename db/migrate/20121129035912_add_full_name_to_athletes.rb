class AddFullNameToAthletes < ActiveRecord::Migration
  def change
    add_column :athletes, :full_name, :string
  end
end
