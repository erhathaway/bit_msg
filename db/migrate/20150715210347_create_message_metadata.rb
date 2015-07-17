class CreateMessageMetadata < ActiveRecord::Migration
  def change
    create_table :message_metadata do |t|
      t.string :iv
      t.string :salt
      t.integer :user_id,           presence: true
      t.integer :message_tag_id
      t.string :transaction_id
      t.datetime :date_posted

      t.timestamps null: false
    end
  end
end
