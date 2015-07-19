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
//= require_tree .



$(document).ready(function() {
  $( ".search_message_decoded").on('click touch', function(){show_message_box(this);});
  $( ".toggle_technical_details").on('click touch', function(){show_technical_details(this);});
  $( '.submit_to_server').on('click', function(){submit_message()});
  $( "#get_coupon" ).on('click touch', function(){get_coupon(this);});

  $(document).on('click touch', function(events) {
    if (!$(event.target).parents().addBack().is('.search_message_decoded')){
      $('#message_details').css("display", "none");
    }
  });

  $('#message_details').on('click touch', function(event) {
    event.stopPropagation();
  });


});

function get_coupon(data){
  $.ajax({
    type: "POST",
    url: "../bit_coupons/get_coupon",
    data: { test: "hello" },
    dataType: "json",
    success: function(data){
      debugger
      $("#coupon_address").text(data["coupon_address"]);
      $("#coupon_code").text(data["coupon_code"]);
    },
    error: function(data){console.log(data)}
  });
}

function show_technical_details(data){
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
        message_id: messageId,
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
// function submit_message(){
//   xhr=new XMLHttpRequest();
//   xhr.open("POST", "message/send", true);
//   xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
//   xhr.send($('textarea#ciphertext').val());
//
//   var message = $('<p>'+$('textarea#ciphertext').val()+'</p>');
//   $('div>#output').parent().append(message);
//   });
//   $('#encrypt').on('click', function() {
//   doEncrypt()
//   });
//   $('#decrypt').on('click', function() {
//   doDecrypt()
//   });
// }
