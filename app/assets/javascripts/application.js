//= require jquery
//= require jquery_ujs
//= require moment.min.js
//= require moment_implementation.js
//= require handlebars.min.js
//= require typeahead_bloodhound.min.js
//= require typeahead_implementation.js
//= require_self

$(document).ready(function() {
  var dismissBtn = $('.home-hero--dismiss-btn'),
      heroMsg = $('.home-hero-message');

  dismissBtn.click(function() {
    heroMsg.hide();
    document.cookie = 'dismissed_hero=true; path=/';
  });
});