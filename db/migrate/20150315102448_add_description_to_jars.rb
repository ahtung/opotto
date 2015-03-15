class AddDescriptionToJars < ActiveRecord::Migration
  def change
    add_column :jars, :description, :text
  end
end
