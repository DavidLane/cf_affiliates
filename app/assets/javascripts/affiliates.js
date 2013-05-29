$('#modal').on('hidden', function() {
    $(this).removeData('modal');
});

$(document).ready(function(){
  
  $("#search-name").select2({
    placeholder: "Select an affiliate...",
  });
  
  $("#search-name").on("change", function(e){
    var affiliate_id = e.val;
    marker = affiliates_map.getMarkerByAffiliateId(affiliate_id);
    affiliates_map.selectMarker(marker);
  });  
  
  $("select#search-region").on("change", function(){
    // affiliates_map.clearMap();
    var region_id = $(this).val();
    $.get("/api/get_region/" + region_id, function(data){
      var region = data[0].region;
      affiliates_map.setCoordsAndZoom(region.coords_lat, region.coords_long, region.zoom);
     
      if(data[0].affiliates.length > 0) {
        var affiliates = data[0].affiliates;
        
        for(var i=0; i < affiliates.length; i++){
          var affiliate = affiliates[i];
          // affiliates_map.showAffiliateMarkerById(affiliate.id);
        }
      }
    });
  })
  
  $('#controls button').tooltip({container: "#controls"});
  
  $("#search-up").on("click", hide_search_form);
  $("#search-down").on("click", show_search_form);  
  
  $("#refresh-btn").on("click", reset);
  
  $("#postcode-distance").change(function(e) {
    run_postcode_search($(this).val(), $("#search-postcode-postcode").val());
  });
  
  $("#search-postcode-postcode").blur(function(e){
    if ($(this).val() != "") {
      run_postcode_search($("#postcode-distance").val(), $(this).val());
    }   
  });
  
  $('.edit-affiliate').on("click", function(e){
    e.stopPropagation();
    
    $.get($(this).attr('href'), function(data) {
      $(".affiliate_info").hide();
      $('#affiliate-edit-box').html("");
      $('#affiliate-edit-box').html(data);
      $('#affiliate-edit-box').show();
    });
    
    return false;
  });
  
  $('#affiliate-edit-box').on('click', '.close', function (e) {
    var parent = $(this).parent();
    var affiliate_id = parent.data("affiliate-id");
    remove_edit_box();
    $("#affiliate-info-" + affiliate_id).show();
  });
  
});

function run_postcode_search(distance, location) {
  affiliates_map.removeSearchMarkers();    
  var zoom = 10;
  var distance = parseInt(distance);
  
  switch(distance) {
    case 10:
      zoom = 10;
      console.log(zoom);
    break;
    case 20:
      zoom = 9;
      console.log(zoom);      
    break;
    case 30:
      zoom = 9;
      console.log(zoom);      
    break;
    case 50:
      zoom = 8;
      console.log(zoom);      
    break;
  }
  
  distance *= 1.609;    
  
  var val = location
  val = val + ", UK";
  
  search_coords_1 = false;    
  
  $.get("http://maps.googleapis.com/maps/api/geocode/json?address=" + val + "&sensor=true", function(data){
    // affiliates_map.clearMap();      
    var lat = data.results[0].geometry.location.lat;
    var lng = data.results[0].geometry.location.lng;
    search_coords_1 = new google.maps.LatLng(lat, lng);
    
    var search_location = new google.maps.Marker({
      position: search_coords_1,
      icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
      map: affiliates_map.getMap()
    }); 
    
    affiliates_map.searchLocationMarkers.push(search_location);
    
    var circle = new google.maps.Circle({
      map: affiliates_map.getMap(),
      radius: distance * 1000,    // 10 miles in metres
      fillColor: '#0088cc',
      strokeWeight: 1,
      strokeColor: "#008BD1"
    });
    
    circle.bindTo('center', search_location, 'position');
    
    affiliates_map.searchRadiusMarkers.push(circle);
    
    affiliates_map.setCoordsAndZoom(lat, lng, zoom);      
    
    /*for(var i=0; i < affiliates_map.mapMarkers.length; i++) {
      var affiliate = affiliates_map.mapMarkers[i];
      var affiliate_pos = affiliate.getPosition();
      if(affiliates_map.isWithinDistanceFromLocation(distance, affiliate_pos, search_coords_1)) {
        affiliates_map.showMarker(affiliate);
      }
      
    } */
  });
}

function remove_edit_box() {
  $('#affiliate-edit-box div').remove();  
}

function close_edit_box() {
  var affiliate_id = $("#affiliate-edit-box .alert").data("affiliate-id");
  remove_edit_box();
  $("#affiliate-info-" + affiliate_id).show();
}

function slide_finish(button) {
  $(button).toggle();  
  $(button).siblings(".btn").toggle();  
  $("#search #search-mini-desc").fadeToggle();
}

function show_search_form() {
  $("#search-down").hide();
  $("#search-up").show();  
  $("#search #search-mini-desc").fadeOut();
  //$(".affiliate_info").hide();
  $("#search-inner").slideDown(400);
}

function hide_search_form() {
  $("#search-up").hide();
  $("#search-down").show();  
  $("#search-inner").slideUp(400, function (){
    $("#search #search-mini-desc").fadeIn();      
  });
}

function reset () {
  affiliates_map.resetMap();
  $("#search-name").select2("val", "");
  $("select#search-region").val("");
  $(".affiliate_info").hide();
  remove_edit_box();
}
