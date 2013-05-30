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
    affiliates_map.removeSearchMarkers();
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
  
  $("#search-postcode .btn").click(function(e){
    $("#search-postcode form").trigger("submit");
  });
  
  $("#search-postcode form").submit(function(e){
    e.stopPropagation();
        
    if ($("#search-postcode-postcode").val() != "") {
      run_postcode_search($("#search-postcode-postcode").val());
    }   
    
    return false;
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

function run_postcode_search(location) {
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
    
    affiliates_map.setCoordsAndZoom(lat, lng, zoom);     
    
    var affiliates_with_distances = []; 
    
    for(var i=0; i < affiliates_map.mapMarkers.length; i++) {
      var affiliate = affiliates_map.mapMarkers[i];
      var affiliate_pos = affiliate.getPosition();
      var distance = affiliates_map.getDistanceFromLocation(affiliate_pos, search_coords_1);
      var affiliate_distance = {affiliate: affiliate.id, distance: distance};
      affiliates_with_distances.push(affiliate_distance);
    }
    
    affiliates_with_distances.sort(function(obj1, obj2) {
      return obj1.distance - obj2.distance;
    });
    
    var closest_affiliate = _.first(affiliates_with_distances);
    
   affiliates_map.selectMarker(affiliates_map.getMarkerByAffiliateId(closest_affiliate.affiliate));
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
