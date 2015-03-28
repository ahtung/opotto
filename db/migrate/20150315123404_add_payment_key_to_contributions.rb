class AddPaymentKeyToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :payment_key, :string
  end
end
