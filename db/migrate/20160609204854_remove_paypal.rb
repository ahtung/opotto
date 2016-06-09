class RemovePaypal < ActiveRecord::Migration
  def change
    remove_column :users, :paypal_member, :boolean
    remove_column :users, :paypal_country, :string
  end
end
