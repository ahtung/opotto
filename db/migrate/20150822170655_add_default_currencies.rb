class AddDefaultCurrencies < ActiveRecord::Migration
  def change
    remove_column :jars, :upper_bound
    add_monetize :jars, :upper_bound, amount: { null: true, default: nil }
    change_column :jars, :upper_bound_currency, :string, default: 'USD', null: false
    change_column :contributions, :amount_currency, :string, default: 'USD', null: false
  end
end
