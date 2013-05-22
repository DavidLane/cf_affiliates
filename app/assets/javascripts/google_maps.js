affiliates = []
markers = [];

$(document).ready(function() {
  var mapOptions = {
    center: new google.maps.LatLng(54.559323, -3.779297),
    zoom: 6,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };  
  
  map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);
      
  var infoWindow = new google.maps.InfoWindow({
  });
  
});

function createMarker(_map, coord_lat, coord_long, _title, id) {
  var latLng = new google.maps.LatLng(coord_lat, coord_long);
  var marker = new google.maps.Marker({
    position: latLng,
    map: _map,
    title: _title
  });
  
  marker.id = id;
  
  google.maps.event.addListener(marker, 'click', function(e){
    mapMarkerClick(marker);
  });
  
  return marker;
}

function mapMarkerClick(marker) {
  $(".affiliate_info").hide();
  $("#affiliate-info-" + marker.id).show();
}

function getMarkerByAffiliateId(affiliate_id) {
  for(var i = 0; i < markers.length; i++) {
    if (markers[i].id == affiliate_id) {
      return markers[i];
    }
  }
}

function selectMarker(marker) {
  mapMarkerClick(marker);  
  marker.setAnimation(google.maps.Animation.BOUNCE);
  setTimeout(function() {
    marker.setAnimation(null);
  }, 1500);
}