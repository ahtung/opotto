class AddUserIndexToInvitations < ActiveRecord::Migration
  def change
    add_index :invitations, :user_id
  end
end
