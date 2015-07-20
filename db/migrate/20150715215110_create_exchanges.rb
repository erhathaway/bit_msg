class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
    t.string :exchange_hash,   null: false, unique: true
    t.integer :block_id,       null: false

    t.timestamps null: false
  end
  add_index :exchanges, :exchange_hash, unique: true
  end
end
