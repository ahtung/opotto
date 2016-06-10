class RemovePreapprovalKeyFromContributions < ActiveRecord::Migration
  def change
    remove_column :contributions, :preapproval_key, :string
  end
end
