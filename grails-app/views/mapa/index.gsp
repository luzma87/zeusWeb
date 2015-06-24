<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 23-Jun-15
  Time: 18:18
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <imp:js src="${g.resource(dir: 'js', file: 'markerwithlabel.js')}"/>
        <imp:js src="${g.resource(dir: 'js/plugins/jquery.xcolor', file: 'jquery.xcolor.min.js')}"/>
        <imp:js src="${g.resource(dir: 'js/plugins/OverlappingMarkerSpiderfier/js', file: 'oms.min.js')}"/>
        <script>
            var gm = google.maps;
            var map, oms;
            var colores = {};

            var markers = [];

            function showPin(latitud, longitud, from, hora, title, image, clase) {
                if (!isNaN(latitud) && !isNaN(longitud)) {
//                    console.log("show pin", latitud, longitud, from, hora, title, image, clase);
                    %{--image = '${g.resource(dir: "images", file: "ping2.png")}';--}%
                    var myLatlng = new gm.LatLng(latitud, longitud);
                    var marker = new gm.Marker({
                        position     : myLatlng,
                        map          : map,
                        title        : title + ": " + hora,
                        icon         : image,
                        labelContent : title + " - " + from + "<br/>" + hora,
                        labelAnchor  : new gm.Point(30, 55),
                        labelClass   : "label-" + clase, // the CSS class for the label
                        labelStyle   : {opacity : 0.90}
                    });
                    if (map) {
                        map.setCenter(marker.getPosition());
                        map.setZoom(17);
                    }
//                    gm.event.addListener(marker, 'idle', toggleBounce(marker));
                    if (oms) {
                        oms.addMarker(marker);
                    }
                    markers.push(marker)
                }
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

//                oms.addListener('click', function (marker, event) {
//                    if (marker.getAnimation() != null) {
//                        marker.setAnimation(null);
//                    } else {
//                        marker.setAnimation(gm.Animation.BOUNCE);
//                    }
//                });

                <g:each in="${tiposIncidencia}" var="d">
                <g:set var="key" value="${d.key}"/>
                <g:set var="icono" value="${d.value.icono}"/>
                <g:set var="title" value="${d.value.title}"/>
                <g:each in="${d.value.mensajes}" var="m">
                var parts = "${m.body}".split(":");
                var loc = parts[parts.length - 1];
                loc = loc.split(",");
                //            setTimeout(function () {
                showPin(loc[0] * 1, loc[1] * 1, "${m.fromJID.split('@')[0]}", "${new Date(m.id).format('dd-MM-yyyy HH:mm')}", "${title}", "${icono}", "${key}");
                //            }, 500);
                </g:each>
                </g:each>

            }
            gm.event.addDomListener(window, 'load', initialize);
        </script>
        <title>Zeus - mapa de incidencias</title>
        <style type="text/css">
        .divIzq {
            height        : 520px;
            border-radius : 5px;
            margin-right  : 0;
        }

        #mensajes {
            height        : 416px;
            overflow      : auto;
            padding       : 10px;
            width         : 100%;

            margin-top    : 0;
            border-radius : 5px;
            border        : 1px solid #36579F;
        }

        .ingreso {
            width      : 100%;
            height     : 100px;
            margin-top : 5px;
        }

        .divDer {
            height                     : 520px;
            overflow                   : auto;
            border-bottom-right-radius : 5px;
            border-top-right-radius    : 5px;
            padding                    : 10px;
            border                     : 1px solid #36579F;

        }

        .mio {
            padding       : 5px;
            display       : inline-block;
            border-radius : 5px;
            background    : #2196f3;
            margin-bottom : 5px;
            color         : #d2d2d2;
            text-align    : left;
            cursor        : pointer;
        }

        .fila {
            width : 100%;
        }

        .mensaje {
            padding       : 5px;
            display       : inline-block;
            border-radius : 5px;
            background    : #ffd781;
            margin-bottom : 5px;
            color         : #000000;
            cursor        : pointer;
            position      : relative;
        }

        .usuario {
            font-weight : bold;
        }

        .txt-ingreso {
            width         : 80%;
            display       : inline-block;
            height        : 100%;
            resize        : none;
            border-radius : 5px;
            padding       : 10px;
        }

        .txt-der {
            text-align : right;
        }

        .col-botones {
            height      : 520px;
            width       : 45px;
            display     : inline-table;
            float       : left;
            margin-left : -12px;

        }

        .btn-barra {
            margin      : 2px;
            width       : 40px;
            height      : 40px;
            line-height : 30px;

        }

        .ventana {
            width  : 150px;
            height : 210px;
        }

        .fila-ventana {
            width   : 100%;
            height  : 25px;
            padding : 3px;
        }

        body {
            margin-bottom : 0 !important;

        }

        .labels {
            color            : #000000;
            background-color : white;
            font-family      : "Lucida Grande", "Arial", sans-serif;
            font-size        : 10px;
            font-weight      : bold;
            text-align       : center;
            width            : 60px;
            border           : 1px solid #36579F;
            border-radius    : 3px;
            white-space      : nowrap;
        }

        .label-emergencia, .label-loc, .label-asL, .label-acL, .label-ssL, .label-inL, .label-lbL {
            color         : #000;
            background    : #ff374d;
            font-family   : "Lucida Grande", "Arial", sans-serif;
            font-size     : 10px;
            font-weight   : bolder;
            text-align    : center;
            padding       : 5px;
            border        : 1px solid #fcf2ff;
            border-radius : 3px;
            white-space   : nowrap;
        }

        .label-asL {
            background : #009688;
            color      : #fff;
        }

        .label-acL {
            background : #C2185B;
        }

        .label-ssL {
            background : #FF5722;
        }

        .label-inL {
            background : #D32F2F;
        }

        .label-lbL {
            background : #FFC107;
        }

        .label-loc {
            background : #4CAF50;
            color      : #fff;
        }
        </style>
    </head>

    <body>

        <div class="row">
            <div class="col-md-12 divDer" id="googleMap">

            </div>
        </div>

        <script type="text/javascript">

        </script>

    </body>
</html>