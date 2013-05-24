$('#modal').on('hidden', function() {
    $(this).removeData('modal');
});

$(document).ready(function(){
  
  $("#search-name").select2({
    placeholder: "Select an affiliate...",
  });
  
  $("#search-name").on("change", function(e){
    var affiliate_id = e.val;
    marker = getMarkerByAffiliateId(affiliate_id);
    selectMarker(marker);
  });  
  
  $("select#search-region").on("change", function(){
    clearMap();
    var region_id = $(this).val();
    $.get("/api/get_affiliates_by_region/" + region_id, function(data){
      if(data.length > 0) {
        for(var i=0; i < data.length; i++){
          var affiliate = data[i];
          showAffiliateMarkerById(affiliate.id);
        }
      }
    });   
  })
  
  $('#controls button').tooltip({container: "#controls"});
  
  $("#search-up").on("click", hide_search_form);
  $("#search-down").on("click", show_search_form);  
  
  $("#refresh-btn").on("click", resetMap);
  
});

function slide_finish(button) {
  $(button).toggle();  
  $(button).siblings(".btn").toggle();  
  $("#search #search-mini-desc").fadeToggle();
}

function show_search_form() {
  $("#search-down").hide();
  $("#search-up").show();  
  $("#search #search-mini-desc").fadeOut();
  $(".affiliate_info").hide();
  $("#search-inner").slideDown(400);
}

function hide_search_form() {
  $("#search-up").hide();
  $("#search-down").show();  
  $("#search-inner").slideUp(400, function (){
    $("#search #search-mini-desc").fadeIn();      
  });
}
