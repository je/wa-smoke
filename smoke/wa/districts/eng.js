var map, featureList, stateSearch = [], positionSearch = [];

$(window).resize(function() {
  sizeLayerControl();
});

$(document).on("click", ".feature-row", function(e) {
  $(document).off("mouseout", ".feature-row", clearHighlight);
  sidebarClick(parseInt($(this).attr("id"), 10));
});

if ( !("ontouchstart" in window) ) {
  $(document).on("mouseover", ".feature-row", function(e) {
    highlight.clearLayers().addLayer(L.circleMarker([$(this).attr("lat"), $(this).attr("lng")], highlightStyle));
  });
}

$(document).on("mouseout", ".feature-row", clearHighlight);

$("#about-btn").click(function() {
  $("#aboutModal").modal("show");
  $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#full-extent-btn").click(function() {
  map.fitBounds(states.getBounds());
  $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#legend-btn").click(function() {
  $("#legendModal").modal("show");
  $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#login-btn").click(function() {
  $("#loginModal").modal("show");
  $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#list-btn").click(function() {
  animateSidebar();
  return false;
});

$("#nav-btn").click(function() {
  $(".navbar-collapse").collapse("toggle");
  return false;
});

$("#sidebar-toggle-btn").click(function() {
  animateSidebar();
  return false;
});

$("#sidebar-hide-btn").click(function() {
  animateSidebar();
  return false;
});

function animateSidebar() {
  $("#sidebar").animate({
    width: "toggle"
  }, 350, function() {
    map.invalidateSize();
  });
}

function sizeLayerControl() {
  $(".leaflet-control-layers").css("max-height", $("#map").height() - 50);
}

function clearHighlight() {
  highlight.clearLayers();
}

function sidebarClick(id) {
  var layer = markerClusters.getLayer(id);
  map.setView([layer.getLatLng().lat, layer.getLatLng().lng], 17);
  layer.fire("click");
  /* Hide sidebar and go to the map on small screens */
  if (document.body.clientWidth <= 767) {
    $("#sidebar").hide();
    map.invalidateSize();
  }
}

function syncSidebar() {
  /* Empty sidebar features */
  $("#feature-list tbody").empty();
  /* Loop through positions layer and add only features which are in the map bounds */
  positions.eachLayer(function (layer) {
    if (map.hasLayer(positionLayer)) {
      if (map.getBounds().contains(layer.getLatLng())) {
        if (layer.feature.properties.B == "Broadcast") {
          var c = "b";
        } else if (layer.feature.properties.B == "Pile") {
          var c = "p";
        } else if (layer.feature.properties.B == "Natural") {
          var c = "n";
        } else {
          var c = "o";
        }
        if (typeof layer.feature.properties.REQUESTS !== 'undefined' && layer.feature.properties.REQUESTS.length > 0) {
          var b = '<small><span class="badge badge-pill small pull-right b' + c + '">' + layer.feature.properties.REQUESTS.length + '</span></small>';
          } else {
          var b = "";
          var c = "";
        }
        $("#feature-list tbody").append('<tr class="feature-row" id="' + L.stamp(layer) + '" lat="' + layer.getLatLng().lat + '" lng="' + layer.getLatLng().lng + '"><td class="feature-name ' + c +'">' + layer.feature.properties.N + b +'<br><small>' + layer.feature.properties.F + ' &sect; ' + layer.feature.properties.D + '<br></small>' + '</td><td style="vertical-align: middle;"><i class="fa fa-chevron-right pull-right"></i></td></tr>');
      }
    }
  });
  /* Update list.js featureList */
  featureList = new List("features", {
    valueNames: ["feature-name"]
  });
  featureList.sort("feature-name", {
    order: "asc"
  });
}

/* Basemap Layers */
var cartoLight = L.tileLayer("https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png", {
  maxZoom: 19,
  attribution: '&copy; <a href="//www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, &copy; <a href="https://cartodb.com/attributions">CartoDB</a>'
});
var usgsImagery = L.layerGroup([L.tileLayer("//basemap.nationalmap.gov/arcgis/rest/services/USGSImageryOnly/MapServer/tile/{z}/{y}/{x}", {
  maxZoom: 15,
}), L.tileLayer.wms("//raster.nationalmap.gov/arcgis/services/Orthoimagery/USGS_EROS_Ortho_SCALE/ImageServer/WMSServer?", {
  minZoom: 16,
  maxZoom: 19,
  layers: "0",
  format: 'image/jpeg',
  transparent: true,
  attribution: "Aerial Imagery courtesy USGS"
})]);

/* Overlay Layers */
var highlight = L.geoJson(null);
var highlightStyle = {
  stroke: false,
  fillColor: "#00FFFF",
  fillOpacity: 0.7,
  radius: 10
};

var states = L.geoJson(null, {
  style: function (feature) {
    return {
      color: "forestgreen",
      dashArray: "3 3",
      weight: 3,
      fill: false,
      opacity: 1,
      clickable: false
    };
  },
  onEachFeature: function (feature, layer) {
    stateSearch.push({
      name: layer.feature.properties.StateName,
      source: "States",
      id: L.stamp(layer),
      bounds: layer.getBounds()
    });
  }
});
$.getJSON("/smoke/wa/wa.js", function (data) {
  states.addData(data);
});

/* Single marker cluster layer to hold all clusters */

var markerClusters = new L.MarkerClusterGroup({
  maxClusterRadius: 5,
  disableClusteringAtZoom: 4,
  spiderfyOnMaxZoom: false,
  showCoverageOnHover: false,
  zoomToBoundsOnClick: true
});

/* Empty layer placeholder to add to layer control for listening when to add/remove positions to markerClusters layer */
var positionLayer = L.geoJson(null);
var positions = L.geoJson(null, {
  pointToLayer: function (feature, latlng) {
      if (feature.properties.B == "Broadcast") {
        var cc = "broad";
        var c = "b";
      } else if (feature.properties.B == "Pile") {
        var cc = "pile";
        var c = "p";
      } else if (feature.properties.B == "Natural") {
        var cc = "natural";
        var c = "n";
      } else {
        var cc = "other";
        var c = "o";
      }
      if (typeof feature.properties.REQUESTS !== 'undefined' && feature.properties.REQUESTS.length > 0) {
        var html = '<span class="badge badge-pill small b' + c + ' m">' + feature.properties.REQUESTS.length + '</span>';
      } else {
        var cc = cc + "0";
        var html = "";
      }
    return L.marker(latlng, {
      icon: L.divIcon({
            //html : html,
            className: 'icon-' + cc,
            iconSize: [10, 10],
        popupAnchor: [0, -25]
      }),
      title: feature.properties.N + " at " + feature.properties.F + " § " + feature.properties.D,
      riseOnHover: true
    });
  },
  onEachFeature: function (feature, layer) {
    if (feature.properties) {
      if (feature.properties.B == "Broadcast") {
        var cc = "broad";
      } else if (feature.properties.B == "Pile") {
        var cc = "pile";
      } else if (feature.properties.B == "Natural") {
        var cc = "natural";
      } else {
        var cc = "other";
      }
      if (typeof feature.properties.REQUESTS !== 'undefined' && feature.properties.REQUESTS.length > 0) {
      } else {
        var cc = cc + "0";
      }
      var title = "<quiet>Prescribed Burn</quiet> <a class='url-break' href='/smoke/" + feature.id + "' target='_blank'>" + feature.properties.N  + "</a> #<a class='url-break' href='/smoke/" + feature.id + "' target='_blank'>" + feature.properties.U + "</a><br><small><quiet>Unit</quiet> <strong>" + feature.properties.F + "</strong> <quiet>Subunit</quiet> <strong>" + feature.properties.D + "</strong>";
      var rows = "<tr><th>ignition date</th><th>ignition time</th><th>duration</th><th>acres</th><th>tons</th><th>multiday</th><th>comments</th><th>fuel moisture</th><th>weather method</th><th>station</th><th>wind speed</th><th>days since rain</th><th>moisture 10hr</th><th>moisture 1000hr</th><th>moisture duff</th><th>black shrub</th><th>black canopy</th><th>black pile</th><th>comments</th></tr>";
      for (var i in feature.properties.REQUESTS) {
        row = "<tr><td>" + feature.properties.REQUESTS[i].PD + "<br>" + feature.properties.REQUESTS[i].AD + "</td><td>" + feature.properties.REQUESTS[i].PH + "<br>" + feature.properties.REQUESTS[i].AH + "</td><td>" + feature.properties.REQUESTS[i].PI + "<br>" + feature.properties.REQUESTS[i].AI + "</td><td>" + feature.properties.REQUESTS[i].PA + "<br>" + feature.properties.REQUESTS[i].AA + "</td><td>" + feature.properties.REQUESTS[i].PT + "<br>" + feature.properties.REQUESTS[i].AT + "</td><td>" + feature.properties.REQUESTS[i].M + "</td><td>" + feature.properties.REQUESTS[i].PC + "</td><td>" + feature.properties.REQUESTS[i].F + "</td><td>" + feature.properties.REQUESTS[i].C + "</td><td>" + feature.properties.REQUESTS[i].S + "</td><td>" + feature.properties.REQUESTS[i].W + "</td><td>" + feature.properties.REQUESTS[i].R + "</td><td>" + feature.properties.REQUESTS[i].M1 + "</td><td>" + feature.properties.REQUESTS[i].M2 + "</td><td>" + feature.properties.REQUESTS[i].MD + "</td><td>" + feature.properties.REQUESTS[i].BS + "</td><td>" + feature.properties.REQUESTS[i].BC + "</td><td>" + feature.properties.REQUESTS[i].BP + "</td><td>" + feature.properties.REQUESTS[i].AC + "</td></tr>";
        rows += row
      }
      var content = "<div class='row'><div class='col-xs-6 col-sm-3 col-md-3 col-lg-3'><table class='table table-striped table-bordered table-condensed small'><tr><th>burn type</th><td>" + feature.properties.B + "</td></tr><tr><th>ignition method</th><td>" + feature.properties.M + "</td></tr><tr><th>burn reason</th><td>" + feature.properties.R + "</td></tr><tr><th>county</th><td>" + feature.properties.C + "</td></tr><tr><th>PLSS</th><td>" + feature.properties.L + "</td></tr><tr><th>coordinates</th><td>" + feature.geometry.coordinates[1] + " " + feature.geometry.coordinates[0] + "</td></tr><tr><th>elevation</th><td>" + feature.properties.E + "</td></tr><tr><th>slope</th><td>" + feature.properties.S + "</td></tr>" + "</table></div><div class='col-xs-6 col-sm-3 col-md-3 col-lg-3'><table class='table table-striped table-bordered table-condensed small'><tr><th>acres</th><td>" + feature.properties.A  + "</td></tr><tr><th>predominant species</th><td>" + feature.properties.G + "</td></tr>" + "<tr><th>forest health exempt?</th><td>" + feature.properties.X + "</td></tr><tr><th>pile tons</th><td>" + feature.properties.PT + "</td></tr><tr><th>pile type</th><td>" + feature.properties.PX + "</td></tr><tr><th>pile calculation method</th><td>" + feature.properties.PCM + "</td></tr><tr><th>landing tons</th><td>" + feature.properties.LT + "</td></tr><tr><th>total permit tons</th><td>" + feature.properties.T + "</td></tr></table></div><div class='col-xs-6 col-sm-3 col-md-3 col-lg-3'><table class='table table-striped table-bordered table-condensed small'><tr><th>dia &lt;0.25\" tons/ac</th><td>" + feature.properties.W1 + "</td></tr><tr><th>dia 0.25\"-1\" tons/ac</th><td>" + feature.properties.W2 + "</td></tr><tr><th>dia 1\"-3\" tons/ac</th><td>" + feature.properties.W3 + "</td></tr><tr><th>dia 3\"-9\" tons/ac</th><td>" + feature.properties.W4 + "</td></tr><tr><th>dia 9\"-20\" tons/ac</th><td>" + feature.properties.W5 + "</td></tr><tr><th>dia &gt;20\" tons/ac</th><td>" + feature.properties.W6 + "</td></tr><tr><th>total broadcast tons/ac</th><td>" + feature.properties.TBTA + "</td></tr><tr><th>broadcast loading method</th><td>" + feature.properties.BLM + "</td></tr></table></div><div class='col-xs-6 col-sm-3 col-md-3 col-lg-3'><table class='table table-striped table-bordered table-condensed small'><tr><th>cut date</th><td>" + feature.properties.HD + "</td></tr><tr><th>snow off date</th><td>" + feature.properties.SO + "</td></tr><tr><th>&lt;3 rotten tons/ac</th><td>" + feature.properties.P3 + "</td></tr><tr><th>shrub tons/ac</th><td>" + feature.properties.H + "</td></tr><tr><th>grass herb tons/ac</th><td>" + feature.properties.GH + "</td></tr><tr><th>litter depth in</th><td>" + feature.properties.LD + "</td></tr><tr><th>duff depth in</th><td>" + feature.properties.DD + "</td></tr><tr><th>duff type</th><td>" + feature.properties.DT + "</td></tr>" + "</table></div></div><div class='row c' style='margin-top:5px;'><div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'><h4 id='feature-title' class='modal-title text-primary'><small><quiet>" + feature.properties.REQUESTS.length + "</quiet> <strong>Burn Requests</strong></small></h4><table class='table table-striped table-bordered table-condensed small'>" + rows + "</table></div></div>";
      var footer = "<span class='pull-left'><small>Added <strong>" + feature.properties.DA + "</strong> by <strong>" + feature.properties.AE + "</strong></small></span><button type='button' class='btn btn-default' data-dismiss='modal'>Close</button>";

      layer.on({
        click: function (e) {
          $("#feature-title").html(title);
          $("#feature-info").html(content);
          $("#feature-footer").html(footer);
          $("#featureModal").modal("show");
          highlight.clearLayers().addLayer(L.circleMarker([feature.geometry.coordinates[1], feature.geometry.coordinates[0]], highlightStyle));
        }
      });
      $("#feature-list tbody").append('<tr class="feature-row" id="' + L.stamp(layer) + '" lat="' + layer.getLatLng().lat + '" lng="' + layer.getLatLng().lng + '"><td class="feature-name">' + layer.feature.properties.UNIT_NAME + '</td><td style="vertical-align: middle;"><i class="fa fa-chevron-right pull-right"></i></td></tr>');
      positionSearch.push({
        name: layer.feature.properties.UNIT_NAME,
        address: layer.feature.properties.DISTRICT,
        source: "Requests",
        id: L.stamp(layer),
        lat: layer.feature.geometry.coordinates[1],
        lng: layer.feature.geometry.coordinates[0]
      });
    }
  }
});

let params = (new URL(document.location)).searchParams;
let adate = params.get("date");
let adist = params.get("district");
  if (adist !== 'undefined' && adist !== null) {
    var yurl = "/smoke/wa/data/?district=" + adist;
  } else {
  if (adate !== 'undefined' && adate !== null) {
    var yurl = "/smoke/wa/data/?date=" + adate + durl;
  } else {
    var yurl = "/smoke/wa/data/?date=2018-xx-xx" + durl;
  }
}
//alert(yurl);


//$.getJSON("year.js", function (data) {
$.getJSON(yurl, function (data) {
  positions.addData(data);
  map.addLayer(positionLayer);

  //var sliderControl = L.control.sliderControl({position: "topleft", layer: positions, range: true});
  //map.addControl(sliderControl);
  //sliderControl.startSlider();

  //alert(Object.getOwnPropertyNames(map.options.layers[2].options));

  //maxClusterRadius,iconCreateFunction,spiderfyOnMaxZoom,showCoverageOnHover,zoomToBoundsOnClick,singleMarkerMode,disableClusteringAtZoom,removeOutsideVisibleBounds,animateAddingMarkers,spiderfyDistanceMultiplier,polygonOptions

  //alert(Object.getOwnPropertyNames(map.options.layers[2]._featureGroup));
  //alert(Object.getOwnPropertyNames(positions.options)); //pointToLayer,onEachFeature
  //alert(Object.getOwnPropertyNames(positions)); //pointToLayer,onEachFeature

  //alert(Object.getOwnPropertyNames(markerClusters._featureGroup._layers[51]._leaflet_id));
  //_layers,_initHooksCalled,_leaflet_events,_map,_leaflet_id
  //options,_featureGroup,_leaflet_id,_nonPointGroup,_inZoomAnimation,_needsClustering,_needsRemoving,_currentShownBounds,_queue,_initHooksCalled,_map,_maxZoom,_gridClusters,_gridUnclustered,_topClusterLevel,_leaflet_events,_zoom

  //alert(Object.getOwnPropertyNames(map.options.layers[2]));
  //crs,fadeAnimation,trackResize,markerZoomAnimation,closePopupOnClick,dragging,inertia,inertiaDeceleration,inertiaMaxSpeed,inertiaThreshold,easeLinearity,worldCopyJump,doubleClickZoom,scrollWheelZoom,touchZoom,bounceAtZoomLimits,tap,tapTolerance,boxZoom,keyboard,keyboardPanOffset,keyboardZoomOffset,zoomControl,attributionControl,zoomAnimation,zoomAnimationThreshold,zoom,center,layers,preferCanvas,maxBounds,maxZoom,minZoom

  //alert(Object.getOwnPropertyNames(map.options.layers._featureGroup._layers.options.title));

  //options,_latlng,_initHooksCalled,feature,defaultOptions,_leaflet_events,_leaflet_id,__parent,_map,_icon,dragging,_shadow,_zIndex

  //options,_featureGroup,_leaflet_id,_nonPointGroup,_inZoomAnimation,_needsClustering,_needsRemoving,_currentShownBounds,_queue,_initHooksCalled,_map,_maxZoom,_gridClusters,_gridUnclustered,_topClusterLevel,_leaflet_events,_zoom

  //alert(Object.getOwnPropertyNames(map.options.layers[3].options));
  //alert(Object.getOwnPropertyNames(map.options.layers[3]._layers));

//options,_layers,_initHooksCalled,_leaflet_id,_map

  //$('#slider-timestamp').html(markerClusters.feature.properties.PD.substr(0, 19));

});

map = L.map("map", {
  zoom: 10,
  center: [45.5231, -122.6765],
  layers: [cartoLight, states, markerClusters, highlight],
  zoomControl: false,
  preferCanvas: true,
  maxBounds: [[-90, -180], [90, 180]],
  maxZoom: 17,
  minZoom: 2,
  attributionControl: false
});

/* Layer control listeners that allow for a single markerClusters layer */
map.on("overlayadd", function(e) {
  if (e.layer === positionLayer) {
    markerClusters.addLayer(positions);
    syncSidebar();
  }
});

map.on("overlayremove", function(e) {
  if (e.layer === positionLayer) {
    markerClusters.removeLayer(positions);
    syncSidebar();
  }
});

/* Filter sidebar feature list to only show features in current map bounds */
map.on("moveend", function (e) {
  syncSidebar();
});

/* Clear feature highlight when map is clicked */
map.on("click", function(e) {
  highlight.clearLayers();
});

/* Attribution control */
function updateAttribution(e) {
  $.each(map._layers, function(index, layer) {
    if (layer.getAttribution) {
      $("#attribution").html((layer.getAttribution()));
    }
  });
}
map.on("layeradd", updateAttribution);
map.on("layerremove", updateAttribution);

var zoomControl = L.control.zoom({
  position: "bottomright"
}).addTo(map);

/* GPS enabled geolocation control set to follow the user's location */
var locateControl = L.control.locate({
  position: "bottomright",
  drawCircle: true,
  follow: true,
  setView: true,
  keepCurrentZoomLevel: true,
  markerStyle: {
    weight: 1,
    opacity: 0.8,
    fillOpacity: 0.8
  },
  circleStyle: {
    weight: 1,
    clickable: false
  },
  icon: "fa fa-location-arrow",
  metric: false,
  strings: {
    title: "My location",
    popup: "You are within {distance} {unit} from this point",
    outsideMapBoundsMsg: "You seem located outside the boundaries of the map"
  },
  locateOptions: {
    maxZoom: 18,
    watch: true,
    enableHighAccuracy: true,
    maximumAge: 10000,
    timeout: 10000
  }
}).addTo(map);

/* Larger screens get expanded layer control and visible sidebar */
if (document.body.clientWidth <= 767) {
  var isCollapsed = true;
} else {
  var isCollapsed = false;
}

var baseLayers = {
  "Street Map": cartoLight,
  "Aerial Imagery": usgsImagery
};

var groupedOverlays = {
  " ": {
    //"States": states,
    "Requests<br><div='small'><span style='margin-left:20px;'>Broadcast <span class='pull-right'><div class='icon-broad' style='height:10px;width:10px;margin-top:2px'></div></span></span><br><span style='margin-left:20px;'>Pile <span class='pull-right'><div class='icon-pile' style='height:10px;width:10px;margin-top:2px'></div></span></span><br><span style='margin-left:20px;'>Natural <span class='pull-right'><div class='icon-natural' style='height:10px;width:10px;margin-top:2px'></div></span></span><br><span style='margin-left:20px;'>Unlit <span class='pull-right'><div class='icon-other0' style='height:10px;width:10px;margin-top:2px'></div></span></span></div>": positionLayer
  }
};

var layerControl = L.control.groupedLayers(baseLayers, groupedOverlays, {
  collapsed: isCollapsed
}).addTo(map);

/* Highlight search box text on click */
$("#searchbox").click(function () {
  $(this).select();
});

/* Prevent hitting enter from refreshing the page */
$("#searchbox").keypress(function (e) {
  if (e.which == 13) {
    e.preventDefault();
  }
});

$("#featureModal").on("hidden.bs.modal", function (e) {
  $(document).on("mouseout", ".feature-row", clearHighlight);
});

/* Typeahead search functionality */
$(document).one("ajaxStop", function () {
  $("#loading").hide();
  sizeLayerControl();
  /* Fit map to states bounds */
  map.fitBounds(states.getBounds());
  featureList = new List("features", {valueNames: ["feature-name"]});
  featureList.sort("feature-name", {order:"asc"});

  var statesBH = new Bloodhound({
    name: "States",
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.name);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: stateSearch,
    limit: 10
  });

  var positionsBH = new Bloodhound({
    name: "Requests",
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.UN);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: positionSearch,
    limit: 10
  });

  var geonamesBH = new Bloodhound({
    name: "GeoNames",
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.name);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: "//api.geonames.org/searchJSON?username=bootleaf&featureClass=P&maxRows=5&countryCode=US&name_startsWith=%QUERY",
      filter: function (data) {
        return $.map(data.geonames, function (result) {
          return {
            name: result.name + ", " + result.adminCode1,
            lat: result.lat,
            lng: result.lng,
            source: "GeoNames"
          };
        });
      },
      ajax: {
        beforeSend: function (jqXhr, settings) {
          settings.url += "&east=" + map.getBounds().getEast() + "&west=" + map.getBounds().getWest() + "&north=" + map.getBounds().getNorth() + "&south=" + map.getBounds().getSouth();
          $("#searchicon").removeClass("fa-search").addClass("fa-refresh fa-spin");
        },
        complete: function (jqXHR, status) {
          $('#searchicon').removeClass("fa-refresh fa-spin").addClass("fa-search");
        }
      }
    },
    limit: 10
  });
  statesBH.initialize();
  positionsBH.initialize();
  geonamesBH.initialize();

  /* instantiate the typeahead UI */
  $("#searchbox").typeahead({
    minLength: 3,
    highlight: true,
    hint: false
  }, {
    name: "States",
    displayKey: "name",
    source: statesBH.ttAdapter(),
    templates: {
      header: "<h4 class='typeahead-header'>States</h4>"
    }
  }, {
    name: "Requests",
    displayKey: "UN",
    source: positionsBH.ttAdapter(),
    templates: {
      header: "<h4 class='typeahead-header'><div class='icon' style='float:left;height:9px;width:9px;margin-top:6px;margin-right:5px;'></div>&nbsp;Requests</h4>",
      suggestion: Handlebars.compile(["{{UN}}<br>&nbsp;<small>{{address}}</small>"].join(""))
    }
  }, {
    name: "GeoNames",
    displayKey: "name",
    source: geonamesBH.ttAdapter(),
    templates: {
      header: "<h4 class='typeahead-header'><img src='../assets/img/globe.png' width='25' height='25'>&nbsp;GeoNames</h4>"
    }
  }).on("typeahead:selected", function (obj, datum) {
    if (datum.source === "States") {
      map.fitBounds(datum.bounds);
    }
    if (datum.source === "Requests") {
      if (!map.hasLayer(positionLayer)) {
        map.addLayer(positionLayer);
      }
      map.setView([datum.lat, datum.lng], 17);
      if (map._layers[datum.id]) {
        map._layers[datum.id].fire("click");
      }
    }
    if (datum.source === "GeoNames") {
      map.setView([datum.lat, datum.lng], 14);
    }
    if ($(".navbar-collapse").height() > 50) {
      $(".navbar-collapse").collapse("hide");
    }
  }).on("typeahead:opened", function () {
    $(".navbar-collapse.in").css("max-height", $(document).height() - $(".navbar-header").height());
    $(".navbar-collapse.in").css("height", $(document).height() - $(".navbar-header").height());
  }).on("typeahead:closed", function () {
    $(".navbar-collapse.in").css("max-height", "");
    $(".navbar-collapse.in").css("height", "");
  });
  $(".twitter-typeahead").css("position", "static");
  $(".twitter-typeahead").css("display", "block");
});

// Leaflet patch to make layer control scrollable on touch browsers
var container = $(".leaflet-control-layers")[0];
if (!L.Browser.touch) {
  L.DomEvent
  .disableClickPropagation(container)
  .disableScrollPropagation(container);
} else {
  L.DomEvent.disableClickPropagation(container);
}
