class QueuedMessagesController < ApplicationController

  def submit_message
    # if verify_recaptcha
      message = params["message"]
      if params["payment_selection"] == "single_use"
        coupon = BitCoupon.find_by(address: params["coupon_address"])
        store_message(message, coupon)
      elsif params["payment_selection"] == "none"
        store_message(message)
      end
    # else
      # render json: { state: "not verified" }
    # end
  end

  private

  def store_message(message, coupon = nil)
    if coupon == nil
      new_message = QueuedMessage.new(message: message, tx_state: "no payment")
    else
      new_message = QueuedMessage.new(message: message, bit_coupon_id: coupon.id, tx_state: "waiting payment")
    end
    if new_message.save
      render json: { state: "message saved to server" }
    else
      render json: { state: "ERROR!" }
    end
  end

end
