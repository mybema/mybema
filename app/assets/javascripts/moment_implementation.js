// Add human readable timestamps

$(document).ready(function() {
  var timeObjects = $('[momentTime]'),
      now = moment();

  timeObjects.each(function(_, el) {
    var time = moment($(el).attr('momentTime'));
    $(el).html(time.from(now));
  });
});