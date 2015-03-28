class AddStatusToJars < ActiveRecord::Migration
  def change
    add_column :jars, :status, :string
  end
end
