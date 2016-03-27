class FixPots < ActiveRecord::Migration
  def change
    remove_index :contributions, :jar_id
    rename_column :contributions, :jar_id, :pot_id
    add_index :contributions, :pot_id

    remove_index :invitations, :jar_id
    rename_column :invitations, :jar_id, :pot_id
    add_index :invitations, :pot_id
  end
end
