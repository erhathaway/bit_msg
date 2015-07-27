// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .



$(document).ready(function() {
  // $( ".search_message_decoded").on('click touch', function(){show_message_box(this);});
  $( ".toggle_technical_details" ).on('click touch', function(){show_technical_details(this);});
  $( "#dont_use_encryption_checkbox, #use_encryption_checkbox" ).on('click touch', function(){show_encryption(this);});
  // $( "#submit_message_form" ).submit(function(){submit_message(this);});
  $( ".single_message" ).mouseover(function(){show_icon(this);});
  $( ".single_message" ).mouseleave(function(){hide_icon(this);});
  $( "#new_message_button_container, #new_message_button_search_nav" ).mouseenter( function(){enter_new_message_button(this)}).mouseleave(function(){leave_new_message_button(this)}  );
  $( "#payment_selection").change(function(){payment_process(this)});
  $( "#encrypt").on('click touch', function(){show_crypt_details(this);});
  $( "#decrypt").on('click touch', function(){hide_crypt_details(this);});
  $( "#submit_message_button").on('click touch', function(){submit_message(this);});
  $( "#front_page_arrow").on('click touch', function(){$.fn.fullpage.moveSectionDown();});
  remove_highlight_item("#step2");
  remove_highlight_item("#step3");
  remove_highlight_item("#step4");
  remove_highlight_item("#step5");

// $( ".new_message_step" ).mouseenter( highlight_item() ).mouseleave( remove_highlight_item(this) );


// highlight captcha box if verification is needed
    setInterval(check_recaptcha, 200);

// highlight if message is ready to be submitted
    setInterval(check_submission_ready, 200);
  // alert($('input[name="encryption_radio"]:checked').val(););

// Popup exit when clicking outside
  $(document).on('click touch', function(events) {
    if (!$(event.target).parents().addBack().is('.search_message_decoded')){
      $('#message_details').css("display", "none");
    }
  });

  $('#message_details').on('click touch', function(event) {
    event.stopPropagation();
  });


});


$(function(){
  if($('body').is('.front_page')){
    //add dynamic script tag  using createElement()
    $('#fullpage').fullpage({
      sectionsColor: ['#f2f2f2', '#040D14', 'white', '#f2f2f2']
    });
  }
});
// function show_new_message_popup(data){
//   var state = $("#new_message_popup").css('display');
//   if (state == 'block'){
//     $("#new_message_popup").css("display", "none");
//   }
//   else {
//     // var messageId = $(data.parentElement).data("messageid");
//     $("#new_message_popup").css("display", "block");
//     // get_message_details(messageId);
//   }
// }

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
    remove_highlight_item(item_id)
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
  // $(item_id).css('border', '1px solid red');
  $(item_id).css('background-color', 'rgba(255,255,255,0.7)');
  // $(item_id).css('color', '#C8CACB');
  $(item_id).css('height', '');

  $(item_id).css('box-shadow', '1px 2px 2px gray');
  $(item_id).children().each(function () {
    $(this).css('display', 'block'); // "this" is the current element in the loop
  });
}

function remove_highlight_item(item_id){
  $(item_id).css('border', '');
  // $(item_id).css('background-color', '#f2f2f2');
  $(item_id).css('background-color', 'white');
  $(item_id).css('box-shadow', '1px 2px 2px gray');

  $(item_id).css('color', 'black');
  // $(item_id).css('box-shadow', 'none');
  $(item_id).children().each(function () {
    $(this).css('display', 'none'); // "this" is the current element in the loop
  });
  $(item_id).css('height', '10px');

}

function show_crypt_details(data){
  setTimeout(function(){
    var iv_data = $("#iv").val()
    var salt_data = $("#salt").val()
    if (iv_data !== ""){
      $("#crypt_info").css('display', 'block');
      $("#iv_show").text(iv_data);
      $("#salt_show").text(salt_data);
      // console.log(iv_data)
    }
  }, 1000);

}

function hide_crypt_details(data){
  $("#crypt_info").css('display', 'none');
}

function payment_process(data) {
  var payment_method = data.value;

  var captcha = $("#g-recaptcha-response").val();
  if ( payment_method === "none" ){
    $(".new_btc_address").css('display', 'none');
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
    $(".new_btc_address").css('display', 'block');
    $("#coupon_address").text(data["coupon_address"]);
  }
  else if (data["state"]=="new_not_verified") {
    $(".new_btc_address").css('display', 'block');
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

function enter_new_message_button(data) {
  // console.log('hi');
  $("#new_message_button, #new_message_button_search_nav").css('border', '2px solid #16AB7D');
  $("#new_message_button, #new_message_button_search_nav").css('color', '#16AB7D');
}
function leave_new_message_button(data) {
  console.log('hello');
  $("#new_message_button, #new_message_button_search_nav").css('border', '2px solid #21CE99');
  $("#new_message_button, #new_message_button_search_nav").css('color', '#21CE99');
}
function show_icon(data) {
  $(data).find(".toggle_technical_details").css('display', 'block');
  $(data).find(".toggle_decode_message").css('display', 'block');
  $(data).find(".toggle_message_link").css('display', 'block');

}

function hide_icon(data) {
  $(data).find(".toggle_technical_details").css('display', 'none');
  $(data).find(".toggle_decode_message").css('display', 'none');
  $(data).find(".toggle_message_link").css('display', 'none');
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

function show_technical_details(data){
  console.log('hi');
  var details = $(data).siblings(".technical_details")
  var state = details.css('display');
  if (state == 'block') { details.css('display', "none"); }
  else { details.css('display', "block"); }
}

function show_message_box(data){
  var state = $("#message_details").css('display');
  if (state == 'block'){
    $("#message_details").css("display", "none");
  }
  else {
    var messageId = $(data.parentElement).data("messageid");
    $("#message_details").css("display", "block");
    get_message_details(messageId);
  }
}

function get_message_details(messageId){
  $.ajax({
    type: "POST",
    url: "../messages/get_data",
    data: {
        message_id: messageId
          },
    dataType: "json",
    success: function(data){update_message_details(data);},
    error: function(data){console.log(data)}
  });
}

function update_message_details(data){
  $("#message_details_raw a").text(data["raw"]);
  $("#message_details_decoded a").text(data["decoded"]);
  $("#message_details_tx_hash a").text(data["tx_hash"]);
  $("#message_details_block_hash a").text(data["block_hash"]);
  $("#message_details_block_height a").text(data["block_height"]);
  $("#message_details_date a").text(data["date_posted"]);
}

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

$(function(){ $(document).foundation(); });
