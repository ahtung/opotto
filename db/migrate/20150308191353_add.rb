class Add < ActiveRecord::Migration
  def change
    add_column :jars, :upper_bound, :money
  end
end
