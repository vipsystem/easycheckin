// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-sprockets
//= require turbolinks
//= require fullcalendar
//= require_tree .

$( document ).ready(function() {

	var formatTime, getUrlVars;

	formatTime = function(time) {
	  if (time[11] === "0") {
	    return time.slice(12, 16);
	  } else {
	    return time.slice(11, 16);
	  }
	};

	getUrlVars = function() {
	  var hash, hashes, i, vars;
	  vars = [];
	  hash = void 0;
	  hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&");
	  i = 0;
	  while (i < hashes.length) {
	    hash = hashes[i].split("=");
	    vars.push(hash[0]);
	    vars[hash[0]] = hash[1];
	    i++;
	  }
	  return vars;
	};

	$(function() {
	  var doctor_id, getDrAvailabilities, tempVar;
	  tempVar = "";
	  doctor_id = getUrlVars()["doctor_id"];
	  console.log(doctor_id);
	  getDrAvailabilities = function() {
	    return $.ajax({
	      url: "/dr_availabilities?doctor_id=" + doctor_id,
	      dataType: 'json',
	      success: function(drAvailabilities) {
	        var clinic_close, clinic_open, day, result, _i, _len, _results;
	        _results = [];
	        for (_i = 0, _len = drAvailabilities.length; _i < _len; _i++) {
	          result = drAvailabilities[_i];
	          if (!result.clinic_open) {
	            continue;
	          }
	          day = result.day.slice(0, 3);
	          clinic_open = formatTime(result.clinic_open);
	          clinic_close = formatTime(result.clinic_close);
	          if (clinic_open !== null) {
	            _results.push($('.fc-' + day).not('.fc-day-header').append(clinic_open + '-' + clinic_close));
	          } else {
	            _results.push(void 0);
	          }
	        }
	        return _results;
	      }
	    });
	  };
	  $("#calendar").fullCalendar({
	    dayClick: function(date) {
	      doctor_id = getUrlVars()["doctor_id"];
	      if (tempVar === "") {
	        $(this).css('background-color', 'grey');
	        tempVar = this;
	      } else {
	        $(this).css('background-color', 'grey');
	        $(tempVar).css('background-color', 'white');
	        tempVar = this;
	      }
	      return $.ajax({
	        data: {
	          clicked_date: date
	        },
	        url: "/dr_availabilities/show?doctor_id=" + doctor_id,
	        success: function(schedule) {
	          return $('#single-day').html(schedule);
	        }
	      });
	    }
	  });
	  $('.fc-button-prev').click(getDrAvailabilities);
	  $('.fc-button-next').click(getDrAvailabilities);
	  $('.fc-button-today').click(getDrAvailabilities);
	  getDrAvailabilities();
	});

});