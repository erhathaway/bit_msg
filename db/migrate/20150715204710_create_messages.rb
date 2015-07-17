class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :transaction_id,         presence: true
      t.string :op_return_data_raw,     presence: true
      t.string :op_return_data_decoded, presence: true
      t.datetime :date_posted,  presence: true
      t.integer :message_tag_id

      t.timestamps null: false
    end
  end
end
