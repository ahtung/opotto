class RenamePaymentKeyToPreapprovalKey < ActiveRecord::Migration
  def change
    rename_column :contributions, :payment_key, :preapproval_key
  end
end
