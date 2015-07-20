class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :block_height,       null: false, unique: true
      t.string :block_hash,         null: false, unique: true
      t.datetime :date_posted

      t.timestamps null: false
    end
    add_index :blocks, :block_height, unique: true
    add_index :blocks, :block_hash, unique: true
  end
end
