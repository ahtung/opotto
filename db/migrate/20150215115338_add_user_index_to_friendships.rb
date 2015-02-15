class AddUserIndexToFriendships < ActiveRecord::Migration
  def change
    add_index :friendships, :user_id
  end
end
