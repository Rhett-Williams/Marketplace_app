class AddUserIdToRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :user_id, :integer
    add_index :requests, :user_id
  end
end
