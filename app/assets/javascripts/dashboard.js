//= require jquery
//= require jquery_ujs
//= require_self

// Make entire row clickable as opposed to just the link text
jQuery(document).ready(function($) {
  $(".js-clickable-row").click(function() {
    window.document.location = $(this).data("url");
  });
});