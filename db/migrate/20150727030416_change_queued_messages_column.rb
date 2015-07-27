class ChangeQueuedMessagesColumn < ActiveRecord::Migration
  def change
    rename_column :queued_messages, :coupon, :bit_coupon_id
  end
end
