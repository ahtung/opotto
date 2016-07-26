class AddCategoryToPots < ActiveRecord::Migration
  def up
    add_column :pots, :category, :integer, default: 0
  end

  def down
    remove_column :pots, :category, :integer
  end
end
