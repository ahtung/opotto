class AddFriendIndexToFriendships < ActiveRecord::Migration
  def change
    add_index :friendships, :friend_id
  end
end
