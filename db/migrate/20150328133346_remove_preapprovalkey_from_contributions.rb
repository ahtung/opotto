class RemovePreapprovalkeyFromContributions < ActiveRecord::Migration
  def change
    remove_column :contributions, :preapproval_key
  end
end
