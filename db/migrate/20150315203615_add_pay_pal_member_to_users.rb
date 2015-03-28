class AddPayPalMemberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal_member, :boolean
  end
end
