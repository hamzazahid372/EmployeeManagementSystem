// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("bootstrap")
require("datatables.net-bs4");
require("bootstrap-datepicker");
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
// require("fullcalendar");
require("moment");
import "@fortawesome/fontawesome-free/js/all";

global.$ = jQuery;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin ],
    events: [
    {
      id: 'event1',
      title: 'Title',
      start: '2020-09-25'
    }
    ]
  });

  calendar.render();
  calendar.on('dateClick', function(info) {
    alert('clicked on ' + info.dateStr);
  });
});



