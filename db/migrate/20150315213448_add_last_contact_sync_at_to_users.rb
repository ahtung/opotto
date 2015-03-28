class AddLastContactSyncAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_contact_sync_at, :datetime
  end
end
