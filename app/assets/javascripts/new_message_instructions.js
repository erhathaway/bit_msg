
function check_recaptcha(){
  var item_id = "#step1"
  if (typeof grecaptcha != "undefined"){
    var captcha = grecaptcha.getResponse();
    if (captcha === "" || captcha === undefined){
      $(".g-recaptcha").css('display', 'block');
      highlight_item(item_id);
    }
    else {
      $(".rc-anchor").css('display', 'none');
      $(".g-recaptcha").css('display', 'none');
      remove_highlight_item(item_id)
      // check_encryption_radio()
    }
  }
}

function check_encryption_radio(){
  var captcha = grecaptcha.getResponse();
  debugger
  if (captcha !== "" || captcha !== undefined){
    var item_id = "#step2"
    var state = $('input[name="encryption_radio"]:checked').val();
    if (state === undefined ){
      highlight_item(item_id)
    }
    else {
      remove_highlight_item(item_id)
      check_message()
    }
  }
}

function check_message(){
  var item_id = "#step3"
  var message = $('textarea#ciphertext').val();

  if (message === "" ){
    highlight_item(item_id)
  }
  else {
    remove_highlight_item(item_id)
    check_payment()
  }
}

function check_payment(){
  var item_id = "#step4"
  var selection = $( "#payment_selection option:selected" ).val()
  if (selection === "choose" ){
    highlight_item(item_id)
  }
  else {
    remove_highlight_item(item_id)
  }
}

function check_submission_ready(){
    var item_id = "#step5"
    if (typeof grecaptcha != "undefined"){
      var selection = $( "#payment_selection option:selected" ).val()
      var message = $('textarea#ciphertext').val();
      var captcha = grecaptcha.getResponse();
      var state = $('input[name="encryption_radio"]:checked').val();

      if (captcha !== "" && selection !== "choose" && message !== "" && state !== undefined ){
        highlight_item(item_id)
      }
      else {
        remove_highlight_item(item_id)
      }
    }
}

function highlight_item(item_id){

  $(item_id).css('background-color', 'white');
  $(item_id).css('height', '');
  $(item_id).css('box-shadow', '1px 2px 2px gray');
  $(item_id).children(".step_text, .step_info").each(function () {
    $(this).css('display', 'block');
  });
}

function remove_highlight_item(item_id){
  // debugger
  $(item_id).css('border', '');
  $(item_id).css('background-color', 'rgba(255,255,255,0.1)');
  $(item_id).css('box-shadow', '1px 2px 2px gray');
  $(item_id).css('color', 'black');
  $(item_id).children(".step_info").each(function () {
    $(this).css('display', 'none');
  });
  $(item_id).css('height', '40px');
  var coupon_address = $("#coupon_address").text();
  if (coupon_address !== ""){
    $(item_id).css('height', '');
    $("#coupon_address").css('display', 'block');
    $("#new_btc_address").css('display', 'block');
  }

}
