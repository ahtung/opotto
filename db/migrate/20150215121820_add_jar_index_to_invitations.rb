class AddJarIndexToInvitations < ActiveRecord::Migration
  def change
    add_index :invitations, :jar_id
  end
end
