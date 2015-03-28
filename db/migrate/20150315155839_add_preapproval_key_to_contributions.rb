class AddPreapprovalKeyToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :preapproval_key, :string
  end
end
