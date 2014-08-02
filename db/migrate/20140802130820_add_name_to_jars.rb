class AddNameToJars < ActiveRecord::Migration
  def change
    add_column :jars, :name, :string
  end
end
