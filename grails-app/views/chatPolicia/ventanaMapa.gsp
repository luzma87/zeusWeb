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

            oms.addListener('click', function (marker, event) {
                if (marker.getAnimation() != null) {
                    marker.setAnimation(null);
                } else {
                    marker.setAnimation(gm.Animation.BOUNCE);
                }
            });
        }
        gm.event.addDomListener(window, 'load', initialize);
    </script>
    <title>Zeus - chat</title>
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
        font-size: 11px !important;
    }

    .ingreso {
        width      : 100%;
        height     : 60px;
        font-size: 11px !important;
        margin-top : 5px;
    }

    .divDer {
        height                     : 475px;
        overflow                   : auto;
        border-bottom-right-radius : 5px;
        border-top-right-radius    : 5px;

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

    .label-emergencia {
        color            : #ffffff;
        background-color : #ff374d;
        font-family      : "Lucida Grande", "Arial", sans-serif;
        font-size        : 10px;
        font-weight      : bolder;
        text-align       : center;
        padding          : 5px;
        border           : 1px solid #fcf2ff;
        border-radius    : 3px;
        white-space      : nowrap;
    }
    .btn-utils{
        width: 120px;
        font-size: 11px;
    }
    </style>
</head>

<body>
<mn:barraTop titulo="Chat policias"/>
<div class="row">

    <div class="col-md-6 divIzq " style="position:relative;display: none" >
        <div class="panel-completo" style="padding: 5px">
            <div class="row fila" style="margin-left: 0px">
                <div class="col-md-12 titulo-panel" style="position: relative">
                    Chat
                </div>
            </div>
            <div class="" id="mensajes"></div>

            <div class="ingreso">
                <textarea class="txt-ingreso" id="mensaje-txt"></textarea>
                <a href="#" class="btn btn-info" id="enviar" style="width: 19%;height: 100%;line-height: 45px;display: inline-block;margin-top: -55px">
                    <i class="fa fa-share-square-o" style="margin-right: 6px"></i> Enviar
                </a>
            </div>
        </div>
    </div>
    <div class="col-md-12" id="map-container">
        <div class="panel-completo" style="padding: 5px">
            <div class="row fila" style="margin-left: 0px">
                <div class="col-md-12 titulo-panel" style="position: relative">
                    <span class="map-hide">Mapa</span>

                </div>
            </div>
            <div class="divDer map-hide" id="googleMap" style="margin-top: 5px">

            </div>
        </div>
    </div>

</div>

<div class="ventana" style="display: none"></div>
<script type="text/javascript">
    var actual = 0;
    var user = "${user}";
    var markers = [];
    var myInterval;
    var first = true;

    var $mensajeTxt = $("#mensaje-txt");
    var $mensajes = $("#mensajes");

    function getContrastYIQ(hexcolor) {
        var r = parseInt(hexcolor.substr(0, 2), 16);
        var g = parseInt(hexcolor.substr(2, 2), 16);
        var b = parseInt(hexcolor.substr(4, 2), 16);
        var yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000;
        return (yiq >= 128) ? 'black' : 'white';
    }

    function getContrast50(hexcolor) {
        return (parseInt(hexcolor, 16) > 0xffffff / 2) ? 'black' : 'white';
    }

    function infoMensaje() {
        openLoader();

        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'chatPolicia',action: 'getInfoMensaje')}",
            data    : "user=" + $(this).attr("user") + "&mensaje=" + $(this).attr("mensaje"),
            success : function (msg) {
                closeLoader()

            }
        });
    }

    function showPin(latitud, longitud, nombre) {
        var image = '${g.resource(dir: "images",file: "ping1.png")}';
        var myLatlng = new gm.LatLng(latitud, longitud);
        var marker = new MarkerWithLabel({
            position     : myLatlng,
            map          : map,
            title        : nombre,
            icon         : image,
            labelContent : nombre,
            labelAnchor  : new gm.Point(30, 55),
            labelClass   : "labels", // the CSS class for the label
            labelStyle   : {opacity : 0.90}
        });
        markers.push(marker)
    }
    function showPinUbicacion(latitud, longitud, nombre, hora) {
//                console.log("show pin ubicacion: ", longitud, latitud, nombre, hora);
        var image = '${g.resource(dir: "images",file: "ping2.png")}';
        var myLatlng = new gm.LatLng(latitud, longitud);
        var marker = new MarkerWithLabel({
            position     : myLatlng,
            map          : map,
            title        : "Asalto reportado: " + hora,
            icon         : image,
            labelContent : nombre,
            labelAnchor  : new gm.Point(30, 55),
            labelClass   : "label-emergencia", // the CSS class for the label
            labelStyle   : {opacity : 0.90}
        });
        if (map) {
            map.setCenter(marker.getPosition());
            map.setZoom(17);
        }
        gm.event.addListener(marker, 'idle', toggleBounce(marker));
        if (oms) {
            oms.addMarker(marker);
        }
        markers.push(marker)
    }
    function appendMensaje(val) {
        var div;
        var container;
        if (val.mensaje.length > 0) {
            var tipo = val.mensaje.substring(0, 3);
            var mns = val.mensaje.substring(4);
            if (tipo == "loc") {
                var loc = val.mensaje.substring(4, val.mensaje.length);
                loc = loc.split(",");
                showPinUbicacion(loc[0] * 1, loc[1] * 1, val.de, val.hora);
            }
        }
        if (val.de == user) {
            div = $("<div class='mio' user='" + val.de + "'  mensaje='" + val.mensaje + "'><span class='usuario'>" + val.de + " (" + val.hora + "): </span>" + mns + "</div>");
            container = $("<div class='fila txt-der'></div>");
            container.append(div);
            $mensajes.append(container);
        } else {

            if (!colores[val.de]) {
                var cl = $.xcolor.random();
                colores[val.de] = {
                    bg   : cl,
                    text : getContrast50(cl.getHex())
                };
            }

            div = $("<div class='mensaje' user='" + val.de + "'  mensaje='" + val.mensaje + "'><span class='usuario'>" + val.de + " (" + val.hora + "): </span>" + mns + "</div>");
            div.css({
                background : colores[val.de].bg,
                color      : colores[val.de].text
            });
            container = $("<div class='fila'></div>");
            container.append(div);
            $mensajes.append(container);
        }
        //div.click(infoMensaje)
        div.qtip({
            content  : {
                title : "Información del usuario",
                text  : function (event, api) {
                    $.ajax({
                        url  : "${g.createLink(controller: 'chatPolicia',action: 'getInfoMensaje')}",
                        data : "user=" + $(this).attr("user") + "&mensaje=" + $(this).attr("mensaje")
                    })
                            .then(function (content) {
                                // Set the tooltip content upon successful retrieval
                                api.set('content.text', content);
                            }, function (xhr, status, error) {
                                // Upon failure... set the tooltip content to error
                                api.set('content.text', status + ': ' + error);
                            });

                    return 'Loading...'; // Set some initial text
                }
            },
            position : {
                viewport : $(window)
            },
            style    : 'qtip-dark',
            show     : {
                event : 'click'
            },
            hide     : 'unfocus'
        });
    }

    function showMensajes() {
        var scroll = false;
        var s = $mensajes.scrollTop();
        $mensajes.scrollTop(s + 1);
        var s2 = $mensajes.scrollTop();
        if (s == s2) {
            scroll = true
        } else {
            $mensajes.scrollTop(s)
        }
        if (first)
            scroll = true;
        first = false;
//                console.log($mensajes.scrollTop(), $mensajes[0].scrollHeight, scroll)
        $.ajax({
            type     : "POST",
            url      : "${g.createLink(controller: 'chatPolicia',action: 'getMessages')}",
            data     : "actual=" + actual,
            dataType : "json",
            success  : function (msg) {
                var data = msg;
                actual = actual + data.length;
                if (data.length > 0) {
                    document.title = "" + data.length + " mensajes nuevos"
                }
                $.each(data, function (i, val) {
                    appendMensaje(val);
                });
                if (scroll) {
                    $mensajes.scrollTop($mensajes[0].scrollHeight);
                    document.title = "Zeus - chat"
                }
            }
        });
    }

    function startInterval() {
        if (myInterval) {
            clearInterval(myInterval);
        }
        showMensajes();
        myInterval = setInterval(function () {
            showMensajes();
        }, 3000);
    }

    startInterval();

    $("#enviar").click(function () {
        var texto = "mns:" + $mensajeTxt.val();
        if ($.trim(texto) != "") {
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'chatPolicia',action: 'enviarMensaje')}",
                data    : "mensaje=msg:" + $mensajeTxt.val(),
                success : function (msg) {
                    $mensajeTxt.val("");
                    $mensajeTxt.html("");
                    startInterval();
                }
            });
            return false
        }
    });
    $mensajeTxt.keydown(function (ev) {
        if (ev.keyCode == 13) {
            var texto = $mensajeTxt.val();
            if ($.trim(texto) != "") {
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'chatPolicia',action: 'enviarMensaje')}",
                    data    : "mensaje=msg:" + $mensajeTxt.val(),
                    success : function (msg) {
                        $mensajeTxt.val("");
                        $mensajeTxt.html("");
                    }
                });
                return false
            }
        }
        return true;
    });
    $(".btn-utils").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'chatPolicia',action: 'enviarMensaje')}",
            data    : "mensaje=" + $(this).data("prefijo")+":"+$(this).attr("title"),
            success : function (msg) {
                $mensajeTxt.val("");
                $mensajeTxt.html("");
            }
        });
        return false
    });
    $("#map-hide").click(function(){
        if($("#map-container").hasClass("col-md-6")){
            $("#map-container").removeClass("col-md-6").addClass("col-md-1")
            $(".map-hide").toggle()
            $(".divIzq").removeClass("col-md-6").addClass("col-md-11")
        }else{
            $("#map-container").removeClass("col-md-1").addClass("col-md-6")
            $(".map-hide").toggle()
            $(".divIzq").removeClass("col-md-11").addClass("col-md-6")
        }
    })
    $("#map-pop").click(function(){
        var ventana = window.open("${g.createLink(controller: 'chatPolicia',action: 'ventanaMapa')}")
        $(".divIzq").removeClass("col-md-6").removeClass("col-md-11").addClass("col-md-12")
        $("#map-container").remove()
    })
</script>
</body>
</html>