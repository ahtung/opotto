class AddAmountCentsToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :amount_cents, :integer, default: 0, null: false
  end
end
