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
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
    eventSources: [
      {
        url: '/events.json'
      }
    ]
});
  calendar.render();
});
