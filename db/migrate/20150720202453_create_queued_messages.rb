class CreateQueuedMessages < ActiveRecord::Migration
  def change
    create_table :queued_messages do |t|
      t.string :raw_message,    null:false
      t.string :hex_message,    null:false
      t.string :message_encoding
      t.integer :bit_coupon_id
      t.string :tx_state,   null:false
      t.string :tx_hash
      t.integer :tx_fee_btc

      t.timestamps null: false
    end
  end
end
