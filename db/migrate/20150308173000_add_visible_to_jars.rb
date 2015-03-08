class AddVisibleToJars < ActiveRecord::Migration
  def change
    add_column :jars, :visible, :boolean
  end
end
