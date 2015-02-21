class RenameEndDateToEndAtForJars < ActiveRecord::Migration
  def up
    add_column :jars, :end_at, :datetime
    remove_column :jars, :end_date
  end
  def down
    add_column :jars, :end_date, :datetime
    remove_column :jars, :end_at
  end
end
