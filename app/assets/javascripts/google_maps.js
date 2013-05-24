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

function clearMap() {
  for(var i = 0; i < markers.length; i++) {
    markers[i].setVisible(false);
  }
}

function showAffiliateMarkerById(affiliate_id) {
  showMarker(getMarkerByAffiliateId(affiliate_id));
}

function showMarker(marker) {
  if (marker !== false) {
    marker.setVisible(true);
  }
}

function mapMarkerClick(marker) {
  map.setCenter(marker.position);
  map.setZoom(14);
  hide_search_form();
  $(".affiliate_info").hide();
  $("#affiliate-info-" + marker.id).show();
}

function getMarkerByAffiliateId(affiliate_id) {
  for(var i = 0; i < markers.length; i++) {
    if (markers[i].id == affiliate_id) {
      return markers[i];
    }
    
    return false;
  }
}

function selectMarker(marker) {
  mapMarkerClick(marker);  
  marker.setAnimation(google.maps.Animation.BOUNCE);
  setTimeout(function() {
    marker.setAnimation(null);
  }, 1500);
}

function resetMap(){
  map.setCenter(new google.maps.LatLng(54.559323, -3.779297));
  map.setZoom(6);
}
