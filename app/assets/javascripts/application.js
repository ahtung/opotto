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
//= require foundation
//= require jquery.transit.min
//= require_tree .

$(function(){ 
	$(document).foundation();
	
	// var toggle = true;
	//
	// // $('#bottom').css({ rotateX: '90deg' });
	//
	// $('body').on('click', function() {
	//
	// 	var x = $('#top').outerWidth() / 2;
	// 	var y = $('#bottom').outerHeight();
	// 	$('#top').transition({
	// 		transformOrigin: x + 'px ' + '0px',
	// 	  perspective: '500px',
	// 	  rotateX: (toggle) ? '-90deg' : '0deg',
	// 		// height: (toggle) ? '0' : '45px'
	// 	}, 1000, function() {
	// 		toggle = !toggle;
	// 	});
	// 	$('#bottom').transition({
	// 		transformOrigin: x + 'px ' + y + 'px',
	// 	  perspective: '500px',
	// 	  rotateX: (toggle) ? '0deg' : '90deg',
	// 		// height: (toggle) ? '45px' : '0'
	// 	}, 1000, function(){
	//     	// $(this).css('transform', '');
	//   	});
	// });
});
