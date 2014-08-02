class CreateJars < ActiveRecord::Migration
  def change
    create_table :jars do |t|
      t.integer :owner_id

      t.timestamps
    end
  end
end
