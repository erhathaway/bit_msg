function payment_process(data) {
  var payment_method = data.value;
  var captcha = $("#g-recaptcha-response").val();
  var coupon_address = $("#coupon_address").text();

  if ( coupon_address !="" ){
    show_payment_details()
    // $("#new_btc_address").css('display', 'none');
  }
  else if (payment_method == "single_use") {
    $.ajax({
      type: "POST",
      url: "/bit_coupons/payment_process",
      dataType: "json",
      data: {
        "g-recaptcha-response": captcha,
        "payment_method": payment_method
            },
      success: function(data){
        insert_payment_data(data);
        },
      error: function(data){
        console.log(data);
        grecaptcha.reset();
        }
    });
  }
}

function insert_payment_data(data) {
  if (data["state"]=="new"){
    // $("#new_btc_address").css('display', 'block');
    $("#coupon_instructions").text("Send 0.0001 BTC to Address:");
    $("#coupon_address").text(data["coupon_address"]);
  }
  // else if (data["state"]=="new_not_verified") {
    // $("#new_btc_address").css('display', 'none');
  // }
  else if (data["state"]=="no value") {
    $("#coupon_instructions").text("Could not find coupon");
    $("#coupon_address").text("");
    $("#coupon_code").text("");
    $("#coupon_value").text("");
    grecaptcha.reset();
  }
  else {
    $("#coupon_instructions").text("Please verify you are not a robot!");
    $("#coupon_address").text("");
    $("#coupon_code").text("");
    $("#coupon_value").text("");
    // grecaptcha.reset();

  };
}

function show_payment_details(){
 $("#step4").find(".step_data").css('display', 'block');
}


function hide_payment_details(){
  $("#step4").find(".step_data").css('display', 'none');
}
