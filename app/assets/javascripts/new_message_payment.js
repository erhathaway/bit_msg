function payment_process(data) {
  var payment_method = data.value;

  var captcha = $("#g-recaptcha-response").val();
  if ( payment_method === "none" ){
    $("#new_btc_address").css('display', 'none');
  }
  else {
    $.ajax({
      type: "POST",
      url: "/bit_coupons/payment_process",
      dataType: "json",
      data: {
        "g-recaptcha-response": captcha,
        "payment_method": payment_method
            },
      success: function(data){
        show_payment_data(data);
        },
      error: function(data){
        console.log(data);
        grecaptcha.reset();
        }
    });
  }
}

function show_payment_data(data) {
  if (data["state"]=="new"){
    $("#new_btc_address").css('display', 'block');
    $("#coupon_address").text(data["coupon_address"]);
  }
  else if (data["state"]=="new_not_verified") {
    $("#new_btc_address").css('display', 'none');
  }
  else if (data["state"]=="no value") {
    $("#coupon_address").text("Could not find coupon");
    $("#coupon_code").text("");
    $("#coupon_value").text("");
    grecaptcha.reset();
  }
  else {
    $("#coupon_address").text("Please verify you are not a robot!")
    $("#coupon_code").text("");
    $("#coupon_value").text("");

  };
}
