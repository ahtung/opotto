class RenameJarsToPots < ActiveRecord::Migration
  def change
    rename_table :jars, :pots
  end
end
