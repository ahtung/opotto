class AddReceiverIdToJars < ActiveRecord::Migration
  def change
    change_table :jars do |t|
      t.belongs_to :receiver, index: true
    end
  end
end
