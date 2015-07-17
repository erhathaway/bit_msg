class CreateMessageMetadata < ActiveRecord::Migration
  def change
    create_table :message_metadata do |t|
      t.string :iv
      t.string :salt
      t.integer :user_id,           null:false
      t.integer :message_tag_id
      t.integer :exchange_id
      t.datetime :date_posted

      t.timestamps null: false
    end
  end
end
