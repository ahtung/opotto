class AddAnonymousToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :anonymous, :boolean
  end
end
