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


$(function(){ $(document).foundation(); });
