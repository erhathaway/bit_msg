require_relative '../../lib/bitcoin/utilities.rb'
require 'digest'

class BitCoupon < ActiveRecord::Base
  belongs_to :user
  has_many :queued_messages

  validates :private_key, presence: true
  validates :public_key, presence: true
  validates :address, presence: true
  validates :coupon_code, presence: true

  def self.new_coupon
    details = new_address
    coupon = SecureRandom.urlsafe_base64[0..7]
    unique_coupon = find_by(coupon_code: coupon)
    while unique_coupon != nil
      coupon = SecureRandom.urlsafe_base64[0..7]
      unique_coupon = find_by(coupon_code: coupon)
    end
    a = create(private_key: details[0],
            public_key: details[1],
            address: details[2],
            coupon_code: coupon)
  end
end
