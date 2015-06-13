$(document).ready(function() {
  $('.submit_to_server').on('click', function() {

    xhr=new XMLHttpRequest();
    xhr.open("POST", "message/send", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
    xhr.send($('textarea#ciphertext').val());


    var message = $('<p>'+$('textarea#ciphertext').val()+'</p>');
    $('div>#output').parent().append(message);
  });
  $('#encrypt').on('click', function() {
	doEncrypt()
  });
  $('#decrypt').on('click', function() {
	doDecrypt()
  });
});
