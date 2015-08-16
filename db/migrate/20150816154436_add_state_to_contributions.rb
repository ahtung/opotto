class AddStateToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :state, :string
  end
end
