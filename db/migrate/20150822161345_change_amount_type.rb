class ChangeAmountType < ActiveRecord::Migration
  def change
    remove_column :contributions, :amount_cents
  end
end
