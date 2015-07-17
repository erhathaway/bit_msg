class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    t.string :tx_hash,   presence: true, unique: true
    t.integer :block_id

    t.timestamps null: false
  end
  add_index :transactions, :tx_hash
  end
end
