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
  $( "#use_encryption" ).on('click touch', function(){show_encryption(this);});
  $( "#submit_message_form" ).submit(function(){submit_message(this);});
  $( ".single_message" ).mouseover(function(){show_icon(this);});
  $( ".single_message" ).mouseleave(function(){hide_icon(this);});
  $( "#new_message_button_container, #new_message_button_search_nav" ).mouseenter( function(){enter_new_message_button(this)}).mouseleave(function(){leave_new_message_button(this)}  );





  // $( "#new_message_button").on('click touch', function(){show_new_message_popup(this);});

  $("#get_coupon").on("ajax:success", function(e, data, status, xhr){
    // debugger
    if (data["state"]=="new"){
      $("#coupon_address").text(data["coupon_address"]);
      $("#coupon_code").text(data["coupon_code"]);
      $("#coupon_value").text(data["coupon_value"]);
      grecaptcha.reset();
    }
    else if (data["state"]=="value") {
      $("#coupon_address").text(data["coupon_address"]);
      $("#coupon_code").text("");
      $("#coupon_value").text(data["coupon_value"]);
      grecaptcha.reset();
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
    }).on( "ajax:error", function(e, xhr, status, error){
      $("#coupon_code").text("Error!")
      });


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

    //call specific functions
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
  // var details = $(data).siblings(".technical_details")
  var state = $(".section").css('display');
  if (state == 'none') {
    $('.crypt').each(function() {$(this).css('display', "block");});
    $('#coupon_buttons').each(function() {$(this).css('margin-top', '273px');});

  }
  else { $('.crypt').each(function() {
    $(this).css('display', "none");});
    $('#coupon_buttons').each(function() {$(this).css('margin-top', '10px');});
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
    var coupon = $('#submit_message_coupon').val();
    var captcha = $("#g-recaptcha-response").val();

    $.ajax({
      type: "POST",
      url: "/queued_messages/submit_message",
      dataType: "json",
      data: {
        "g-recaptcha-response": captcha,
        message: message,
        coupon: coupon
            },
      success: function(data){console.log(data);},
      error: function(data){console.log(data)}
    });
}

$(function(){ $(document).foundation(); });
