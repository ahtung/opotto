class RemoveStatusFromContributions < ActiveRecord::Migration
  def change
    remove_column :contributions, :status, :string
  end
end
