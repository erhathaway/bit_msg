
$(document).ready(function() {
  // $( ".search_message_decoded").on('click touch', function(){show_message_box(this);});
  $( ".toggle_technical_details" ).on('click touch', function(){show_technical_details(this);});
  $( "#dont_use_encryption_checkbox, #use_encryption_checkbox" ).on('click touch', function(){show_encryption(this);});
  $( ".single_message" ).mouseover(function(){show_icon(this);});
  $( ".single_message" ).mouseleave(function(){hide_icon(this);});
  $( "#new_message_button_container, #new_message_button_search_nav" ).mouseenter( function(){enter_new_message_button(this)}).mouseleave(function(){leave_new_message_button(this)}  );
  $( "#payment_selection").change(function(){payment_process(this)});
  $( "#encrypt").on('click touch', function(){show_crypt_details(this);});
  $( "#decrypt").on('click touch', function(){hide_crypt_details(this);});
  $( "#submit_message_button").on('click touch', function(){submit_message(this);});
  $( "#front_page_arrow").on('click touch', function(){$.fn.fullpage.moveSectionDown();});

  $('textarea#ciphertext').on('change keyup paste', function(){check_length(this)});

  remove_highlight_item("#step1");
  remove_highlight_item("#step2");
  remove_highlight_item("#step3");
  remove_highlight_item("#step4");
  remove_highlight_item("#step5");

  // highlight captcha box if verification is needed
  // highlight other instructions if possible
    setInterval(check_recaptcha, 100);

  // check if form is ready to be submitted
    setInterval(check_submission_ready, 100);
  
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
