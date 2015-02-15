class ConvertAmountToMoney < ActiveRecord::Migration
  def up
    remove_column :contributions, :amount
    add_monetize :contributions, :amount
  end

  def down
    remove_monetize :contributions, :amount
    add_column :contributions, :amount, :integer
  end
end
