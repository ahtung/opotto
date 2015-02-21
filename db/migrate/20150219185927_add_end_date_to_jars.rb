class AddEndDateToJars < ActiveRecord::Migration
  def change
    add_column :jars, :end_date, :datetime
  end
end
