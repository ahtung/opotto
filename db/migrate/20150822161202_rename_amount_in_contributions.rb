class RenameAmountInContributions < ActiveRecord::Migration
  def change
    rename_column :contributions, :amount, :amount_cents
  end
end
