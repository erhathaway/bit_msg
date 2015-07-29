function submit_message(data){

    var message = $('textarea#ciphertext').val();
    var coupon_address = $("#coupon_address").text();
    var coupon_code = $("#coupon_code").text();
    var payment_selection = $( "#payment_selection").val();
    var captcha = $("#g-recaptcha-response").val();

    alert("Message submitted!")
    $.ajax({
      type: "POST",
      url: "/queued_messages/submit_message",
      dataType: "json",
      data: {
        "g-recaptcha-response": captcha,
        message: message,
        coupon_code: coupon_code,
        coupon_address: coupon_address,
        payment_selection: payment_selection
            },
      success: function(data){console.log(data);},
      error: function(data){console.log(data)}
    });
}
