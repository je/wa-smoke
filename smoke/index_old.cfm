<cfinclude template="/smoke/use.cfm">

<cfif structkeyexists(session,'msg_text')>
    <cfif session.msg_text NEQ ''>
        <cfset msg_text = '#session.msg_text#'>
        <cfset msg_status = '#session.msg_status#'>
        <cfset session.msg_text = ''>
        <cfset session.msg_status = ''>
    </cfif>
</cfif>

<cfinclude template="/lo.cfm">

    <cfset lastyear = '#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss tt")#'>
    <cfset dateq = '#DateFormat(now(),"yyyy-mm-dd")#'>
    <cfset qyyyy = '#DateFormat(dateq,"yyyy")#'>
    <cfset qmm = '#DateFormat(dateq,"mm")#'>
    <cfset qmm = ''>
    <cfset qdd = '#DateFormat(dateq,"dd")#'>
    <cfset qdd = ''>
    <cfquery name="tada" datasource="Washington_Smoke_Production">
    SELECT latitude,longitude,BURN_UNIT_ID_NO,Burn_Project_Name
    FROM Pre_Burn p
    <cfif #dateq# NEQ ''>
        <cfif #qyyyy# NEQ ''>
        WHERE year(date_Added) = #qyyyy#
        </cfif>
        <cfif #qmm# NEQ ''>
        AND month(date_Added) = #qmm#
        </cfif>
        <cfif #qdd# NEQ ''>
        AND day(date_Added) = #qdd#
        </cfif>
    <cfelse>
        WHERE year(date_Added) = 2016
    </cfif>
    ORDER BY date_added DESC,district ASC,Burn_Project_Name
    </cfquery>

    <cfquery name="rada" datasource="Washington_Smoke_Production">
    SELECT p.latitude,p.longitude
    FROM Burn_Request r, Pre_Burn p
    <cfif #dateq# NEQ ''>
        <cfif #qyyyy# NEQ ''>
        WHERE year(r.date_Added) = #qyyyy#
        </cfif>
        <cfif #qmm# NEQ ''>
        AND month(r.date_Added) = #qmm#
        </cfif>
        <cfif #qdd# NEQ ''>
        AND day(r.date_Added) = #qdd#
        </cfif>
    <cfelse>
        WHERE year(r.date_Added) = 2016
    </cfif>
    AND p.b_key = r.plan_key
    AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
    ORDER BY r.date_added DESC
    </cfquery>

    <cfquery name="uada" datasource="Washington_Smoke_Production">
    SELECT p.latitude,p.longitude
    FROM Post_Burn u, Burn_Request r, Pre_Burn p
    <cfif #dateq# NEQ ''>
        <cfif #qyyyy# NEQ ''>
        WHERE year(u.date_Added) = #qyyyy#
        </cfif>
        <cfif #qmm# NEQ ''>
        AND month(u.date_Added) = #qmm#
        </cfif>
        <cfif #qdd# NEQ ''>
        AND day(u.date_Added) = #qdd#
        </cfif>
    <cfelse>
    WHERE year(u.date_Added) = 2016
    </cfif>
    AND u.R_Key = r.R_Key
    AND p.b_key = r.plan_key
    AND r.Burn_Permit_Number = p.Burn_Unit_ID_No
    ORDER BY u.date_added DESC
    </cfquery>

<div style="padding-right:20px;">

    <div class="panel panel-default" style="max-width:none;">
        <div class="panel-heading">
            <h3 class="panel-title">
            <a href="/smoke/"><strong>Washington State Smoke Reporting</strong></a>
            </h3>
        </div>

        <div class="panel-body">

            <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
				<br>
				<a href='/smoke/district/'>/district/</a> - districts<br>
				<br>
				<a href='/smoke/date/?2016-09-14'>/date/?2016-09-14</a> - example date page<br>
				<a href='/smoke/date/?2016-09-xx'>/date/?2016-09-xx</a> - example month page<br>
				<a href='/smoke/date/?2016-xx-xx'>/date/?2016-xx-xx</a> - example year page<br>
				<br>
				<a href='/smoke/json/?date=2016-09-14'>/json/?date=2016-09-14</a> - example public json daily<br>
				<a href='/smoke/json/?date=2016-09-xx'>/json/?date=2016-09-xx</a> - example public json monthly<br>
				<a href='/smoke/json/?date=2016-xx-xx'>/json/?date=2016-xx-xx</a> - example public json yearly<br>
                <br>
                <a href='/smoke/accomp/?date=2016-09-14'>/accomp/?date=2016-09-14</a> - example accomp summary daily<br>
                <a href='/smoke/accomp/?date=2016-09-xx'>/accomp/?date=2016-09-xx</a> - example accomp summary monthly<br>
                <a href='/smoke/accomp/?date=2016-xx-xx'>/accomp/?date=2016-xx-xx</a> - example accomp summary yearly<br>
				<br>
            </div>

            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/leaflet.css">

            <style>
                #map {
                    width: 100%;
                    height: 380px;
                }
                .info {
                    padding: 6px 8px;
                    font: 14px/16px Arial, Helvetica, sans-serif;
                    background: white;
                    background: rgba(255,255,255,0.8);
                    box-shadow: 0 0 15px rgba(0,0,0,0.2);
                    border-radius: 5px;
                }
                .info h4 {
                    margin: 0 0 5px;
                    color: #777;
                }
                .legend {
                    text-align: left;
                    line-height: 18px;
                    color: #555;
                }
                .legend i {
                    width: 18px;
                    height: 18px;
                    float: left;
                    margin-right: 8px;
                    opacity: 0.7;
                }
                .obsicon {
                background:OrangeRed;
                text-align:center;
                vertical-align:middle;
                border-radius:10px;
                }
            </style>

            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
                <div id="map"></div>
            </div>

<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/leaflet.js"></script>
<script src="/smoke/leaflet-providers.js"></script>
<script src="//maps.google.com/maps/api/js?v=3.2&sensor=false"></script>
<script src="/smoke/google.js"></script>


            <script type="text/javascript" src="/smoke/us-states.js"></script>
            <script type="text/javascript">

                //var map = L.map('map').setView([37.8, -96], 4);

                var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' + '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                        'Imagery <a href="http://mapbox.com">Mapbox</a>', mbUrl = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpandmbXliNDBjZWd2M2x6bDk3c2ZtOTkifQ._QA7i5Mpkd_m30IGElHziw';

                var grayscale   = L.tileLayer(mbUrl, {id: 'mapbox.light', attribution: mbAttr});

                var gmap_terrain = new L.Google('TERRAIN');
                var gmap_hybrid = new L.Google('HYBRID');

                var map = L.map('map', {
                    layers: [gmap_terrain]
                }).setView([47.7511, -120.7401], 4);;

                var baseLayers = {
                    "Terrain Basemap": gmap_terrain,
                    "Satellite Basemap": gmap_hybrid,
                    "Grayscale Basemap": grayscale
                };

                L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6IjZjNmRjNzk3ZmE2MTcwOTEwMGY0MzU3YjUzOWFmNWZhIn0.Y8bhBaUMqFiPrDRW9hieoQ', {
                    maxZoom: 18,
                    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
                    id: 'mapbox.light'
                });


                // control that shows state info on hover
                var info = L.control();

                info.onAdd = function (map) {
                    this._div = L.DomUtil.create('div', 'info');
                    this.update();
                    return this._div;
                };

                info.update = function (props) {
                    this._div.innerHTML = '<h4>US Population Density</h4>' +  (props ?
                        '<b>' + props.name + '</b><br />' + props.density + ' people / mi<sup>2</sup>'
                        : 'Hover over a state');
                };

                //info.addTo(map);


                // get color depending on population density value
                function getColor(d) {
                    return d > 1000 ? '#800026' :
                           d > 500  ? '#BD0026' :
                           d > 200  ? '#E31A1C' :
                           d > 100  ? '#FC4E2A' :
                           d > 50   ? '#FD8D3C' :
                           d > 20   ? '#FEB24C' :
                           d > 10   ? '#FED976' :
                                      '#FFEDA0';
                }

                function style(feature) {
                    return {
                        weight: 2,
                        opacity: 1,
                        color: 'white',
                        dashArray: '3',
                        fillOpacity: 0.7,
                        fillColor: getColor(feature.properties.density)
                    };
                }

                function highlightFeature(e) {
                    var layer = e.target;

                    layer.setStyle({
                        weight: 5,
                        color: '#666',
                        dashArray: '',
                        fillOpacity: 0.7
                    });

                    if (!L.Browser.ie && !L.Browser.opera) {
                        layer.bringToFront();
                    }

                    info.update(layer.feature.properties);
                }

                var geojson;

                function resetHighlight(e) {
                    geojson.resetStyle(e.target);
                    info.update();
                }

                function zoomToFeature(e) {
                    map.fitBounds(e.target.getBounds());
                }

                function onEachFeature(feature, layer) {
                    layer.on({
                        mouseover: highlightFeature,
                        mouseout: resetHighlight,
                        click: zoomToFeature
                    });
                }

                //geojson = L.geoJson(statesData, {
                //    style: style,
                //    onEachFeature: onEachFeature
                //});

                //map.attributionControl.addAttribution('Population data &copy; <a href="http://census.gov/">US Census Bureau</a>');


                var legend = L.control({position: 'bottomright'});

                legend.onAdd = function (map) {

                    var div = L.DomUtil.create('div', 'info legend'),
                        grades = [0, 10, 20, 50, 100, 200, 500, 1000],
                        labels = [],
                        from, to;

                    for (var i = 0; i < grades.length; i++) {
                        from = grades[i];
                        to = grades[i + 1];

                        labels.push(
                            '<i style="background:' + getColor(from + 1) + '"></i> ' +
                            from + (to ? '&ndash;' + to : '+'));
                    }

                    div.innerHTML = labels.join('<br>');
                    return div;
                };

                //legend.addTo(map);

                var obsIcon = L.divIcon({
                    className: 'obsicon',
                    iconSize: [10, 10]
                })

                var wa = {"type":"Feature","id":"53","properties":{"name":"Washington","density":102.6,"style": {
                        color: "#019fde",
                        weight: 1,
                        opacity: 1,
                        fillColor: "",
                        fillOpacity: 0.4
                    }
},"geometry":{"type":"MultiPolygon","coordinates":[[[[-117.033359,49.000239],[-117.044313,47.762451],[-117.038836,46.426077],[-117.055267,46.343923],[-116.92382,46.168661],[-116.918344,45.993399],[-118.988627,45.998876],[-119.125551,45.933153],[-119.525367,45.911245],[-119.963522,45.823614],[-120.209985,45.725029],[-120.505739,45.697644],[-120.637186,45.746937],[-121.18488,45.604536],[-121.217742,45.670259],[-121.535404,45.725029],[-121.809251,45.708598],[-122.247407,45.549767],[-122.762239,45.659305],[-122.811531,45.960537],[-122.904639,46.08103],[-123.11824,46.185092],[-123.211348,46.174138],[-123.370179,46.146753],[-123.545441,46.261769],[-123.72618,46.300108],[-123.874058,46.239861],[-124.065751,46.327492],[-124.027412,46.464416],[-123.895966,46.535616],[-124.098612,46.74374],[-124.235536,47.285957],[-124.31769,47.357157],[-124.427229,47.740543],[-124.624399,47.88842],[-124.706553,48.184175],[-124.597014,48.381345],[-124.394367,48.288237],[-123.983597,48.162267],[-123.704273,48.167744],[-123.424949,48.118452],[-123.162056,48.167744],[-123.036086,48.080113],[-122.800578,48.08559],[-122.636269,47.866512],[-122.515777,47.882943],[-122.493869,47.587189],[-122.422669,47.318818],[-122.324084,47.346203],[-122.422669,47.576235],[-122.395284,47.800789],[-122.230976,48.030821],[-122.362422,48.123929],[-122.373376,48.288237],[-122.471961,48.468976],[-122.422669,48.600422],[-122.488392,48.753777],[-122.647223,48.775685],[-122.795101,48.8907],[-122.756762,49.000239],[-117.033359,49.000239]]],[[[-122.718423,48.310145],[-122.586977,48.35396],[-122.608885,48.151313],[-122.767716,48.227991],[-122.718423,48.310145]]],[[[-123.025132,48.583992],[-122.915593,48.715438],[-122.767716,48.556607],[-122.811531,48.419683],[-123.041563,48.458022],[-123.025132,48.583992]]]]}};

               mp = new L.GeoJSON(wa, {
                style: function(feature) {
                    return feature.properties.style
                }
              });

                var obslist = new L.LayerGroup();
                <cfloop query='tada'><cfoutput>
                var o#Burn_Unit_ID_No# = {
                  "type": "Feature",
                  "geometry": {
                    "type": "Point",
                    "coordinates": [
                            #longitude#, #latitude#
                        ]
                  },
                </cfoutput>
                  "properties": {
                    "name": "Point",
                    "style": {
                        color: "OrangeRed",
                        weight: 1,
                        opacity: 1,
                        fillColor: "OrangeRed",
                        fillOpacity: 0.4
                    }
                  }
                };

               <cfoutput>
               o#Burn_Unit_ID_No# = new L.GeoJSON(o#Burn_Unit_ID_No#, {
                style: function(feature) {
                    return feature.properties.style
                }
              });
              //o#Burn_Unit_ID_No#.addTo(map);
              mp.addTo(map);
              </cfoutput></cfloop>

                <cfloop query='tada'>
                <cfoutput>
                var op#Burn_Unit_ID_No# = L.marker([ #latitude# , #longitude# ], {icon: obsIcon,});
                op#Burn_Unit_ID_No#.addTo(map);
                op#Burn_Unit_ID_No#.bindPopup('<a href="/smoke/data/?#Burn_Unit_ID_No#">#Burn_Project_Name#</a>');
                </cfoutput>
                </cfloop>
                map.whenReady(function () {
                    window.setTimeout(function () {
                        map.fitBounds(mp.getBounds());
                    }.bind(map), 200);
                }, this);
            </script>

        </div>
        <div class="panel-footer">
            <small>
            </small>        
        </div>
    </div>

</div>

<cfinclude template="/gutter.cfm">

</body>
</html>
