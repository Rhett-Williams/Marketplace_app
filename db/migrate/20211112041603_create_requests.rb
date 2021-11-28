class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :display_name
      t.string :reason
      t.integer :dollar_amount

      t.timestamps
    end
  end
end
