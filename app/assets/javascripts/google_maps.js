var UKAffiliatesMap = function() {
  this.mapOptions = {
      center: new google.maps.LatLng(54.559323, -3.779297),
      zoom: 6,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  
  this.map = false;
  this.mapMarkers = [];
  this.searchLocationMarkers = [];
  this.searchRadiusMarkers = [];
  
  this.createMap = function(){
    this.map = new google.maps.Map(document.getElementById("map-canvas"),
    this.mapOptions);
  }
  
  this.getMap = function() {
    return this.map;
  }
  
  this.createMarker = function(coord_lat, coord_long, _title, id) {
    var latLng = new google.maps.LatLng(coord_lat, coord_long);
    var marker = new google.maps.Marker({
      position: latLng,
      map: this.map,
      title: _title
    });
    
    marker.id = id;
    
    google.maps.event.addListener(marker, 'click', function(e){
      affiliates_map.mapMarkerClick(marker);
    });
    
    return marker;
  }
  
  this.clearMap = function () {
    for(var i = 0; i < this.mapMarkers.length; i++) {
      this.mapMarkers[i].setVisible(false);
    }
    
    this.removeSearchMarkers();
  }
  
  this.removeSearchMarkers = function() {
    for (var i=0; i < this.searchLocationMarkers.length; i++) {
      this.searchLocationMarkers[i].setMap(null);
      this.searchLocationMarkers.splice(i, 1);
    }
    
    for (var i=0; i < this.searchRadiusMarkers.length; i++) {
      this.searchRadiusMarkers[i].setMap(null);
      this.searchRadiusMarkers.splice(i, 1);
    }    
  }
  
  
  this.setCoordsAndZoom = function(coords_lat, coords_long, zoom) {
    var coords = new google.maps.LatLng(coords_lat, coords_long);
    this.map.setCenter(coords);
    
    this.map.setZoom(zoom);    
  }
  
  this.resetMap = function (){
    affiliates_map.setCoordsAndZoom(54.559323, -3.779297, 6);
  }
  
  this.showRegion = function(coords_lat, coords_long, zoom) {
    affiliates_map.setCoordsAndZoom(coords_lat, coords_long, zoom);
  }
  
  this.showAffiliateMarkerById = function(affiliate_id) {
    this.showMarker(this.getMarkerByAffiliateId(affiliate_id));
  } 
  
  this.showMarker = function(marker) {
    if (marker !== false) {
      marker.setVisible(true);
    }
  } 
  
  this.mapMarkerClick = function(marker) {
    this.map.setCenter(marker.position);
    this.map.setZoom(14);
    hide_search_form();
    remove_edit_box();    
    $(".affiliate_info").hide();
    $("#affiliate-info-" + marker.id).show();    
  }
  
  this.getMarkerByAffiliateId = function(affiliate_id) {
    for(var i = 0; i < this.mapMarkers.length; i++) {
      if (this.mapMarkers[i].id == affiliate_id) {
        return this.mapMarkers[i];
      }
    }
    
    return false;  
  }
  
  this.selectMarker = function(marker) {
    if (marker) {
      this.mapMarkerClick(marker);  
      marker.setAnimation(google.maps.Animation.BOUNCE);
      setTimeout(function() {
        marker.setAnimation(null);
      }, 1500);
    }
  }
  
  this.isWithinDistanceFromLocation = function(distance, current_location, destination) {
    var distance_between = google.maps.geometry.spherical.computeDistanceBetween(current_location, destination);
    return (distance_between/1000) < distance;  
  }  
   
}

var affiliates_map = new UKAffiliatesMap();

$(document).ready(function() {
  affiliates_map.createMap();
});
