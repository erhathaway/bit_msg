class BitCouponsController < ApplicationController

  def payment_process
    if verify_recaptcha
      if params["commit"] == "New coupon"
        coupon = BitCoupon.new_coupon
        render json: { state: "new",
                       coupon_address: coupon.address,
                       coupon_code: coupon.coupon_code,
                       coupon_value: coupon.btc_value}
      elsif params["commit"] == "Check value"
        coupon = BitCoupon.find_by(coupon_code: params["data"][:coupon_code])

        if coupon == nil
          render json: { state: "no value" }
        else
          render json: { state: "value",
                         coupon_address: coupon.address,
                         coupon_code: coupon.coupon_code,
                         coupon_value: coupon.btc_value}
        end
      end
    else
      render json: { state: "not verified" }
    end
  end

end
