class CreateQueuedMessages < ActiveRecord::Migration
  def change
    create_table :queued_messages do |t|
      t.string :message,    null:false
      t.string :coupon
      t.string :tx_state,   null:false
      t.string :tx_hash

      t.timestamps null: false
    end
  end
end
