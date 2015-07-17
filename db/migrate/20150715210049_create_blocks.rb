class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :block_height,       null:false, presence: true, unique: true
      t.string :block_hash,         null:false, presence: true, unique: true
      t.datetime :parsed_date
      t.datetime :date_posted

      t.timestamps null: false
    end
    add_index :blocks, :block_height
    add_index :blocks, :block_hash
  end
end
