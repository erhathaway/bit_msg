// this function is depreciated (it is still being called but currently not showing anything)
// Display should be refactored to left hand instruction column

function d2h(d) {
    return d.toString(16);
}

function stringToHex (tmp) {
    var str = '',
        i = 0,
        tmp_len = tmp.length,
        c;

    for (; i < tmp_len; i += 1) {
        c = tmp.charCodeAt(i);
        str += d2h(c) + ' ';
    }
    return str;
}

function check_length(data){
  var message = data.value
  var hex_message = stringToHex(message)
  // return hex_message.length
  console.log(hex_message.length);
}

function show_crypt_details(data){
  setTimeout(function(){
    var iv_data = $("#iv").val()
    var salt_data = $("#salt").val()
    if (iv_data !== ""){
      // $("#crypt_info").css('display', 'block');
      $("#iv_show").text(iv_data);
      $("#salt_show").text(salt_data);
      // console.log(iv_data)
    }
  }, 1000);

}

function hide_crypt_details(data){
  $("#crypt_info").css('display', 'none');
}


function show_encryption(data){
  var state = $('input[name="encryption_radio"]:checked').val();
  // var state = $(".section").css('display');

  if (state == 'use_encryption') {
    $('.crypt').each(function() {$(this).css('display', "block");});
    $('#ciphertext').css('height', '10px');
    var iv_data = $("#iv").val()
    if (iv_data !== ""){
      $("#crypt_info").css('display', 'block');
    }

  }
  else { $('.crypt').each(function() {
    $(this).css('display', "none");});
    $('#ciphertext').css('height', '100px');
    $("#crypt_info").css('display', 'none');
  }
}

function submit_message(data){

    var message = $('textarea#ciphertext').val();
    var coupon_address = $("#coupon_address").text();
    var coupon_code = $("#coupon_code").text();
    var payment_selection = $( "#payment_selection").val();
    var captcha = $("#g-recaptcha-response").val();
    // var iv = $("#iv_show").text();
    // var salt = $("#salt_show").text();
    var iv = $("#iv").val()
    var salt = $("#salt").val()

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
  $('#step5').text("SUCCESS!");


  // hide existing message form
  $('#ckey').css('display', 'none');
  $("#pplaintext").css('display', 'none');
  $("#buttons").css('display', 'none');
  $("#crypt_info").css('display', 'none');
  $('#pciphertext').css('display', 'none');


  $('#final_message').css('display', 'block');
  if (payment_selection == "single_use") {
    $("#payment_type").text("You have choosen to include a small fee in order to incentivise the transaction.");
    $("#payment_type_elaboration").text("This fee is given to the miners. It allows your message to be taken up into the bitcoin ledger in a few minutes (rather than hours or days).");
    $("#payment_instructions").text("Please send 0.0001 BTC within the next 24 hrs to the following address:");
    $("#payment_address").text(coupon_address);
  }
  else {
    $("#payment_type").text("You have choosen to NOT include a small fee that would incentivise the transaction.");
    $("#payment_type_elaboration").text("This means that your message may take hours, days, or never be taken up into the bitcoin ledger.");
    $("#payment_instructions").text("It is highly recommended that you include a fee next time if you want to ensure your message is sent.");
  }


  if (iv != "" && salt != ""){
    $("#encryption_iv").html("IV: "+iv);
    $("#encryption_salt").html("Salt: "+salt);
  }
  else {
    $('#encryption_message').css('display', 'none');
  }
}
