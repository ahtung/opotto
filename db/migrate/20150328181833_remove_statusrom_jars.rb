class RemoveStatusromJars < ActiveRecord::Migration
  def change
    remove_column :jars, :status
  end
end
