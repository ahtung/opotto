class CreateAbuses < ActiveRecord::Migration
  def change
    create_table :abuses do |t|
      t.string :email
      t.string :title
      t.string :referer
      t.string :description
      t.boolean :confirmed, :default => false
      t.integer :resource_id
      t.string :resource_type
      t.datetime :created_at
    end
  end
end
