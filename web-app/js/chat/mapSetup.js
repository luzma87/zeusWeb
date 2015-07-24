var gm = google.maps;
var map, oms;
var colores = {};
var infowindow;
var actual = 0;
var actualInc = 0;
var markers = [];
var myInterval;
var first = true;

function startInterval() {
    if (myInterval) {
        clearInterval(myInterval);
    }
    showMensajes();
    myInterval = setInterval(function () {
        showMensajes();
    }, 3000);
}

function toggleBounce(marker) {
    if (marker.getAnimation() != null) {
        marker.setAnimation(null);
    } else {
        marker.setAnimation(gm.Animation.BOUNCE);
    }
}
function stopBounce(pos) {

    if (marker.getAnimation() != null) {
        marker.setAnimation(null);
    } else {
        marker.setAnimation(gm.Animation.BOUNCE);
    }
}

function initialize() {
    var mapProp = {
        center    : new gm.LatLng(-0.16481615, -78.47895741),
        zoom      : 15,
        mapTypeId : gm.MapTypeId.ROADMAP
    };
    map = new gm.Map(document.getElementById("googleMap"), mapProp);

    oms = new OverlappingMarkerSpiderfier(map, {
        markersWontMove : true,
        markersWontHide : true,
        keepSpiderfied  : true
    });

    infowindow = new gm.InfoWindow({
        content  : "DUMMY",
        maxWidth : 300
    });

    oms.addListener('spiderfy', function (markers) {
//                    console.log("spiderfy");
        for (var i = 0; i < markers.length; i++) {
            markers[i].setAnimation(null);
        }
        infowindow.close();
    });

    oms.addListener('unspiderfy', function (markers) {
//                    console.log("unspiderfy");
        for (var i = 0; i < markers.length; i++) {
            markers[i].setAnimation(gm.Animation.BOUNCE);
        }
        infowindow.close();
    });

    oms.addListener('click', function (marker, event) {
//                    if (marker.getAnimation() != null) {
        marker.setAnimation(null);
//                    } else {
//                        marker.setAnimation(gm.Animation.BOUNCE);
//                    }

//                    console.log("fecha: ", marker.fecha, " from: ", marker.from, " msg: ", marker.mensaje);

        infowindow.setContent("<i class='fa fa-spinner fa-spin fa-lg' style='color: #FFA46B;' title='Cargando...'></i>" +
                              " Cargando...");

        if (infowindow) {
            infowindow.close();
        }
        infowindow.open(map, marker);
        infoWindowAjax(marker, function (data) {
            infowindow.setContent(data);
        });
    });
    startInterval();
}

gm.event.addDomListener(window, 'load', initialize);