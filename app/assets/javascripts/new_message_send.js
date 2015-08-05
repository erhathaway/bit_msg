function submit_message(data){

    var message = $('textarea#ciphertext').val();
    var coupon_address = $("#coupon_address").text();
    var coupon_code = $("#coupon_code").text();
    var payment_selection = $( "#payment_selection").val();
    var captcha = $("#g-recaptcha-response").val();
    var iv = $("#iv_show").text();
    var salt = $("#salt_show").text();
    clear_screen(message,payment_selection,coupon_address,coupon_code,iv,salt);

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
      success: function(data){
        console.log(data);
        clear_screen(message,payment_selection,coupon_address,coupon_code,iv,salt);
      },
      error: function(data){console.log(data)}
    });
}

function clear_screen(message,payment_selection,coupon_address,coupon_code,iv,salt){
// new_message_step
  $('.new_message_step').css('display', 'none');
  $('#step5').css('display', 'block');
  $('#step5').text("MESSAGE SENT");


  // hide existing message form
  $('#ckey').css('display', 'none');
  $("#pplaintext").css('display', 'none');
  $("#buttons").css('display', 'none');
  $("#crypt_info").css('display', 'none');
  $('#pciphertext').css('display', 'none');


  $('#final_message').css('display', 'block');
  if (payment_selection == "single_use") {
    $("#payment_type").text("You have choosen to include a small fee in order to incentivise the transaction. This fee is given to the miners. It allows your message to be taken up into the bitcoin ledger in a few minutes (rather than hours or days)");
    $("#payment_instructions").text("Please send 0.0001 BTC within the next 24 hrs to the following address");
    $("#payment_address").text(coupon_address);
  }
  else {
    $("#payment_type").text("You have choosen to NOT include a small fee that would incentivise the transaction. This means that your message may take hours, days, or never be taken up into the bitcoin ledger. It is highly recommended that you include a fee if you want to insure your message is sent.")
  }


  if (iv != "" && salt != ""){
    $("#encryption_iv").text(iv);
    $("#encryption_salt").text(salt);
  }
  else {
    $('#encryption_message').css('display', 'none');
  }
}
