class AddPaidAtToJars < ActiveRecord::Migration
  def change
    add_column :jars, :paid_at, :datetime
  end
end
