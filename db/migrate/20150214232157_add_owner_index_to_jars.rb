class AddOwnerIndexToJars < ActiveRecord::Migration
  def change
    add_index :jars, :owner_id
  end
end
