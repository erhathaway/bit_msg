class BitCouponsController < ApplicationController

  def get_coupon
    if verify_recaptcha
      coupon = BitCoupon.new_coupon
      render json: { state: "verified",
                     coupon_address: coupon.address,
                     coupon_code: coupon.coupon_code }
    else
      render json: { state: "not verified" }
    end
  end

  def show

  end

end
