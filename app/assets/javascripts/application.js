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
  $( ".search_message_container").click(function(){get_message(this);});
  $('.submit_to_server').on('click', function(){submit_message()});
});


function get_message(data){
  var state = $("#message_details").css('display')
  if (state == 'block'){
    $("#message_details").css("display", "none");
  }
  else {
    var messageId = $(data).data("messageid");
    console.log(messageId);
    $("#message_details").css("display", "block");

    $.ajax({
      type: "POST",
      url: "../messages/get_data",
      data: {
          message_id: messageId,
            },
      dataType: "json",
      success: function(data){
        $("#message_details_raw a").text(data["raw"]);
            console.log(data);
            },
      error: function(data){
        debugger;
      }
    });
  }
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
