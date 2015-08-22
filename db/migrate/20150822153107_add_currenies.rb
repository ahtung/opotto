class AddCurrenies < ActiveRecord::Migration
  def change
    add_column :jars, :currency, :string
    add_column :contributions, :currency, :string
  end
end
