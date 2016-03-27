class AddPaypalCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal_country, :string
  end
end
