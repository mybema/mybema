//= require jquery
//= require jquery_ujs
//= require moment.min.js
//= require moment_implementation.js
//= require handlebars.min.js
//= require typeahead_bloodhound.min.js
//= require typeahead_implementation.js
//= require_self

// Users can dismiss the hero message by clicking on the X.
// This sets a cookie that determines visibility of the message.
$(document).ready(function() {
  var dismissBtn = $('#dismiss-hero-msg'),
      heroMsg = $('.home-hero-message');

  dismissBtn.click(function() {
    heroMsg.hide();
    document.cookie = 'dismissed_hero=true; path=/';
  });
});