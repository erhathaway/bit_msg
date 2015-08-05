class BitCouponsController < ApplicationController

  def payment_process
    if params["payment_method"] == "single_use"
      # there is a problem with verify. its not actually needed unless a user inputs a multiuse coupon, but it still needs to be fixed!
      # if verify_recaptcha
        coupon = BitCoupon.new_coupon
        render json: { state: "new",
                       coupon_address: coupon.address,
                       coupon_value: coupon.btc_value}
      # else
        # render json: { state: "new_not_verified" }
      # end
    # elsif params["payment_method"] == "multi_use_new"
    #   coupon = BitCoupon.find_by(coupon_code: params["data"][:coupon_code])
    #
    #   if coupon == nil
    #     render json: { state: "no value" }
    #   else
    #     render json: { state: "value",
    #                    coupon_address: coupon.address,
    #                    coupon_code: coupon.coupon_code,
    #                    coupon_value: coupon.btc_value}
    #   end
    else
      render json: { state: "no payment" }
    end

  end

end
