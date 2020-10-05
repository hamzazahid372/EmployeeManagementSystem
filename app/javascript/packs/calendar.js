import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import timeGridPlugin from '@fullcalendar/daygrid';
require("fullcalendar");
require("moment");
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
     plugins: [ dayGridPlugin, interactionPlugin, timeGridPlugin ],
  headerToolbar: {
    right: 'dayGridMonth,dayGridWeek,dayGridDay' // buttons for switching between views
  },
  eventSources: [
    {
      url: '/events.json', // use the `url` property
      color: 'yellow',    // an option!
    }
  ]
});
  calendar.render();
  calendar.on('dateClick', function(info) {
    $.get({url: '/events/new.js', data: {start: info.dateStr}});
  });
});
