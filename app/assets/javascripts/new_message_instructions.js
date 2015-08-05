function check_recaptcha(){
  var item_id = "#step1"
  if (typeof grecaptcha != "undefined"){
    var captcha = grecaptcha.getResponse();
    if (captcha === "" || captcha === undefined){
      $(".g-recaptcha").css('display', 'block');
      highlight_item(item_id);
    }
    else {
      remove_highlight_check(item_id, "check")
      check_encryption_radio()
    }
  }
}

function check_encryption_radio(){
  var item_id = "#step2"
  var state = $('input[name="encryption_radio"]:checked').val();
  if (state === undefined ){
    highlight_item(item_id)
  }
  else {
    remove_highlight_check(item_id, "check")
    check_message()
  }
}

function check_message(){
  var item_id = "#step3"
  var message = $('textarea#ciphertext').val();

  if (message === "" ){
    highlight_item(item_id)
  }
  else {
    remove_highlight_check(item_id, "check")
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
    remove_highlight_check(item_id, "check")
  }
  // check which type of payment data should be displayed
  if (selection == "single_use"){show_payment_details()}
  else if (selection == "none" || selection == "choose") {hide_payment_details()}

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


function remove_highlight_check(item_id, state){
  if (state == "startup"){
    remove_highlight_item(item_id);
  }
  if (state == "check") {
  //   // ($('#hello').is(':hover'))
    if ($(item_id).is(':hover')){
      // prevent submission if not ready
      highlight_item(item_id);
    }
    else { remove_highlight_item(item_id);
    }
  }
}

function remove_highlight_item(item_id){
  $(item_id).css('border', '');
  $(item_id).css('background-color', 'rgba(255,255,255,0.1)');
  $(item_id).css('box-shadow', '1px 2px 2px gray');
  $(item_id).css('color', 'black');
  $(item_id).children(".step_info").each(function () {
    $(this).css('display', 'none');
  });
  // $(item_id).css('height', '40px');
  var coupon_address = $("#coupon_address").text();
  var coupon_instructions = $("#coupon_instructions").text();

  // if (coupon_address !== ""){
  //   $(item_id).css('height', '');
  //   $("#coupon_address").css('display', 'block');
  // };
  // if (coupon_address !== ""){
  //   $(item_id).css('height', '');
  //   $("#coupon_instructions").css('display', 'block');
  // };

}
