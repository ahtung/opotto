class DropAmountFromContributions < ActiveRecord::Migration
  def change
    remove_column :contributions, :amount_cents
    remove_column :contributions, :amount_currency
  end
end
