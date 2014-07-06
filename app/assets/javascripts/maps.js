$(document).ready(function() {
	var active_map = L.map('active_map').setView([41.86296, -87.62506], 13);
	L.tileLayer('http://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
			'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="http://mapbox.com">Mapbox</a>', id: 'examples.map-i86knfo3'}).addTo(active_map);
	
	// var inactive_map = L.map('inactive_map', { zoomControl:false }).setView([41.86296, -87.62506], 13);
	// L.tileLayer('http://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
	//		'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
	//		'Imagery © <a href="http://mapbox.com">Mapbox</a>', id: 'examples.map-i86knfo3'}).addTo(inactive_map);
});