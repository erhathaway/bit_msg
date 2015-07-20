class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :exchange_id,           null:false
      t.string :op_return_data_raw,     null:false
      t.string :op_return_data_decoded, null:false
      t.string :op_return_data_custom
      t.integer :message_tag_id

      t.timestamps null: false
    end
  end
end
