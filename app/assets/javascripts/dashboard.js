//= require _ga
//= require jquery
//= require jquery_ujs
//= require moment.min.js
//= require moment_implementation.js
//= require handlebars.min.js
//= require typeahead_bloodhound.min.js
//= require typeahead_implementation.js
//= require_self

$(document).ready(function() {

  // Make entire row clickable as opposed to just the link text
  $(".js-clickable-row").click(function() {
    window.document.location = $(this).data("url");
  });

  // dismiss flash messages
  $('#dismiss-flash-msg').click(function() {
    $('#flash-notices').hide();
  });
});