class RenameCurrencyInContributions < ActiveRecord::Migration
  def change
    rename_column :contributions, :currency, :amount_currency
  end
end
