class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    t.string :tx_hash,   null:false, unique: true
    t.integer :block_id, null:false

    t.timestamps null: false
  end
  add_index :transactions, :tx_hash
  end
end
