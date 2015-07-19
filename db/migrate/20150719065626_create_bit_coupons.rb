class CreateBitCoupons < ActiveRecord::Migration
  def change
    create_table :bit_coupons do |t|
    t.string :private_key,    null:false, unique: true
    t.string :public_key,     null:false, unique: true
    t.string :address,        null:false, unique: true
    t.string :coupon_code,     null:false, unique: true
    t.integer :btc_value
    t.integer :user_id

    t.timestamps null: false
  end
  add_index :bit_coupons, :coupon_code
  end
end
