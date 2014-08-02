class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.belongs_to :user
      t.belongs_to :jar
      t.timestamps
    end
  end
end
