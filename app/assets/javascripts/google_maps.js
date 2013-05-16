$(document).ready(function() {
  var mapOptions = {
    center: new google.maps.LatLng(54.559323, -3.779297),
    zoom: 6,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  
  map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);  
});