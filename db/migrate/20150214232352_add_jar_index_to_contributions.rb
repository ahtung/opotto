class AddJarIndexToContributions < ActiveRecord::Migration
  def change
    add_index :contributions, :jar_id
  end
end
