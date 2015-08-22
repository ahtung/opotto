class AddAmountMoneyToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :amount, :money
  end
end
