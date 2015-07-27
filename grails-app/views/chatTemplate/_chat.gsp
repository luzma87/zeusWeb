<div class="row">
    <div class="col-md-6 divIzq " style="position:relative;">
        <div class="panel-completo" style="padding: 5px">
            <div class="row fila" style="margin-left: 0; margin-top: 10px">
                <div class="col-md-12 titulo-panel" style="position: relative">
                    Chat
                    <g:set var="i" value="${0}"/>
                    <g:each in="${botones}" var="boton">
                        <g:set var="btn" value="${boton.value}"/>
                        <g:if test="${btn.title}">
                            <a href="#" class="btn ${btn.clase} btn-utils"
                               title="${btn.title}" id="${boton.key}" data-prefijo="${btn.prefijo}"
                               style="position: absolute; right: ${i * 60 + 20}px;top: -10px">
                                <i class="fa ${btn.icon} fa-2x"></i>
                            </a>
                            <g:set var="i" value="${i + 1}"/>
                        </g:if>
                    </g:each>
                    <g:if test="${policia}">
                        <a href="#" class="btn btn-verde" title="Mensaje a la comunidad" id="btnCom"
                           style="position: absolute; right: ${i * 60 + 20}px;top: -10px">
                            <i class="fa fa-rss fa-2x"></i>
                        </a>
                    </g:if>
                </div>
            </div>

            <div class="" id="mensajes"></div>

            <div class="ingreso">
                <textarea class="txt-ingreso" id="mensaje-txt"></textarea>
                <a href="#" class="btn btn-verde" id="enviar" style="width: 19%;height: 100%;line-height: 45px;display: inline-block;margin-top: -55px">
                    <i class="fa fa-share-square-o" style="margin-right: 6px"></i> Enviar
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-6" id="map-container">
        <div class="panel-completo" style="padding: 5px">
            <div class="row fila" style="margin-left: 0">
                <div class="col-md-12 titulo-panel" style="position: relative">
                    <span class="map-hide">Mapa</span>

                    <a href="#" style="position: absolute;right: 30px" id="map-hide" title="Ocultar/Mostrar">
                        <i class="fa fa-level-down"></i>
                    </a>
                </div>
            </div>

            <div class="divDer map-hide" id="googleMap" style="margin-top: 5px">

            </div>
        </div>
    </div>

</div>

<div class="row" style="margin-top: 10px">
    <div class="col-md-12">
    </div>
</div>

<div class="ventana" style="display: none"></div>

<script type="text/javascript">
    var user = "${user}";
    var $mensajeTxt = $("#mensaje-txt");
    var $mensajes = $("#mensajes");

    var tipos = {
        loc : {
            icono : "${resource(dir: 'images/pins/'+folder, file: 'location32.png')}",
            title : "Ubicación"
        },
        asL : {
            icono : "${resource(dir: 'images/pins/'+folder, file: 'thief1.png')}",
            title : "Asalto"
        },
        acL : {
            icono : "${resource(dir: 'images/pins/'+folder, file: 'cars1.png')}",
            title : "Accidente"
        },
        ssL : {
            icono : "${resource(dir: 'images/pins/'+folder, file: 'businessman205.png')}",
            title : "Sospechoso"
        },
        inL : {
            icono : "${resource(dir: 'images/pins/'+folder, file: 'bill7.png')}",
            title : "Intruso"
        },
        lbL : {
            icono : "${resource(dir: 'images/pins/'+folder, file: 'healthyfood1.png')}",
            title : "Libadores"
        }
    };

    function infoWindowAjax(marker, callback) {
        return $.ajax({
            url  : "${g.createLink(controller: control,action: 'getInfoMensajeChat_ajax')}",
            data : {
                from  : marker.from,
                fecha : marker.fecha,
                msg   : marker.mensaje,
                id    : marker.incId
            }
        }).done(callback)
                .fail(function (jqXHR, textStatus, errorThrown) {
                    alert(errorThrown);
                });
    }

    function infoMensaje() {
        openLoader();
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: control,action: 'getInfoMensaje_ajax')}",
            data    : "user=" + $(this).attr("user") + "&mensaje=" + $(this).attr("mensaje"),
            success : function (msg) {
                closeLoader();
            }
        });
    }

    function showPinUbicacion(latitud, longitud, from, hora, tipo, mensaje, id) {
        console.log(latitud, longitud, from, hora, tipo, mensaje, id);
        if (!isNaN(latitud) && !isNaN(longitud)) {
            var t = tipos[tipo];

            var img = {
                url    : t.icono,
                size   : new google.maps.Size(32, 32),
                origin : new google.maps.Point(0, 0),
                anchor : new google.maps.Point(16, 32)
            };

            var myLatlng = new gm.LatLng(latitud, longitud);
            var marker = new gm.Marker({
                from         : from,
                fecha        : hora,
                mensaje      : mensaje,
                position     : myLatlng,
                map          : map,
                title        : t.title + ": " + hora,
                icon         : img,
                labelContent : t.title + " - " + from + "<br/>" + hora,
                labelAnchor  : new gm.Point(30, 55),
//                        labelClass   : "label-" + clase, // the CSS class for the label
                labelStyle   : {opacity : 0.90},
                incId        : id
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
    }

    function cambiarEstado(id, usuario, tipo) {
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: control, action: 'cambiaEstado_ajax')}",
            data    : "id=" + id,
            success : function (msg) {
                infowindow.close();
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: control, action: 'enviarMensaje_ajax')}",
                    data    : {
                        mensaje : "und:" + tipo + " reportado por " + usuario + ": Unidades en camino"
                    },
                    success : function (msg) {
                        startInterval();
                        for (var i = 0; i < markers.length; i++) {
                            var m = markers[i];
                            if (m.incId == id) {
                                m.setMap(null)
                            }
                        }
                    }
                });
            }
        });
    }

    function quitar(id, usuario, tipo) {
        for (var i = 0; i < markers.length; i++) {
            var m = markers[i];
            if (m.incId == id) {
                m.setMap(null)
            }
        }
    }

    function appendMensaje(val) {
        var divNombre;
        var divMensaje;
        var container;
        var esEmergencia = false;
        if (val.mensaje.length > 4) {
            var tipo = val.mensaje.substring(0, 3);
            var mns = val.mensaje.substring(4);
            if (tipo in tipos) {
                esEmergencia = true;
                var parts = val.mensaje.split(":");
                var loc = parts[parts.length - 1];
                loc = loc.split(",");
//                console.log(val);
                showPinUbicacion(loc[0] * 1, loc[1] * 1, val.de, val.hora, tipo, val.mensaje, val.id);
            }
        }
        if (val.de == user) {
            divNombre = $("<div class='nombre mio'>" + val.de + " (" + val.hora + "): </div>");
//                    divMensaje = $("<div class='mio' user='" + val.de + "'  mensaje='" + val.mensaje + "'><span class='usuario'>" + val.de + " (" + val.hora + "): </span>" + mns + "</div>");
            divMensaje = $("<div class='mensaje' user='" + val.de + "'  mensaje='" + val.mensaje + "'>" + mns + "</div>");
            container = $("<div class='fila txt-der'></div>");
            container.append(divNombre);
            container.append(divMensaje);
            $mensajes.append(container);
        } else {
            if (!colores[val.de]) {
                var cl = $.xcolor.random();
                colores[val.de] = cl;
            }
            divNombre = $("<div class='nombre'>" + val.de + " (" + val.hora + "): </div>");
//                    divMensaje = $("<div class='mensaje' user='" + val.de + "'  mensaje='" + val.mensaje + "'><span class='usuario'>" + val.de + " (" + val.hora + "): </span>" + mns + "</div>");
            divMensaje = $("<div class='mensaje' user='" + val.de + "'  mensaje='" + val.mensaje + "'>" + mns + "</div>");
//                    divMensaje.css({
//                        background : colores[val.de].bg,
//                        color      : colores[val.de].text
//                    });
            divNombre.css({
                color : colores[val.de]
            });
            container = $("<div class='fila' data-user='" + val.de + "'></div>");
            container.append(divNombre);
            container.append(divMensaje);
            $mensajes.append(container);
        }
        //div.click(infoMensaje)

        divMensaje.qtip({
            content  : {
                title : "Información del usuario",
                text  : function (event, api) {
                    $.ajax({
                        url  : "${g.createLink(controller: control,action: 'getInfoMensaje_ajax')}",
                        data : {
                            user    : $(this).attr("user"),
                            mensaje : $(this).attr("mensaje")
                        }
                    })
                            .then(function (content) {
                                // Set the tooltip content upon successful retrieval
                                api.set('content.text', content);
                            }, function (xhr, status, error) {
                                // Upon failure... set the tooltip content to error
                                api.set('content.text', status + ': ' + error);
                            });

                    return 'Cargando...'; // Set some initial text
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
        if (val.de == user) {
            ion.sound.play("s1");
        } else {
            if (esEmergencia) {
                ion.sound.play("s2");
            } else {
                ion.sound.play("s3");
            }
        }
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
            url      : "${g.createLink(controller: control, action: 'getMessages_ajax')}",
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

    function enviarMensaje(texto) {
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: control,action: 'enviarMensaje_ajax')}",
            data    : {
                mensaje : texto
            },
            success : function (msg) {
                $mensajeTxt.val("");
                $mensajeTxt.html("");
                startInterval();
                closeLoader()
            },
            error   : function () {
                closeLoader();
            }
        });
    }

    $(function () {
        // init bunch of sounds
        ion.sound({
            sounds : [
                {
                    alias : "s1",
                    name  : "tap"
                },
                {
                    alias : "s2",
                    name  : "door_bell"
                },
                {
                    alias : "s3",
                    path  : "${resource(dir:'audio')}/",
                    name  : "popup_notification"
                }
            ],

            // main config
            path      : "${resource(dir:'js/plugins/ion.sound-3.0.4/sounds')}/",
            preload   : true,
            multiplay : true,
            volume    : 1,

            ready_callback : function (obj) {
//                    obj.name;     // File name
//                    obj.alias;    // Alias (if set)
//                    obj.ext;      // File .ext
//                    obj.duration; // Seconds
//                        console.log("READY", obj.name, obj.alias, obj.ext, obj.duration);
            },
            ended_callback : function (obj) {
//                    obj.name;     // File name
//                    obj.alias;    // Alias (if set)
//                    obj.part;     // Part (if sprite)
//                    obj.start;    // Start time (sec)
//                    obj.duration; // Seconds
//                        console.log("ENDED", obj.name, obj.alias, obj.ext, obj.duration);
            }
        });

        $("#enviar").click(function () {
            var texto = "msg:" + $mensajeTxt.val();
            if ($.trim(texto) != "") {
                enviarMensaje(texto);
                return false
            }
        });

        $mensajeTxt.keydown(function (ev) {
            if (ev.keyCode == 13) {
                var texto = "msg:" + $mensajeTxt.val();
                if ($.trim(texto) != "") {
                    enviarMensaje(texto);
                    return false
                }
            }
            return true;
        });

        $(".btn-utils").click(function () {
            openLoader();
            var texto = "msg:" + $(this).attr("title");
            enviarMensaje(texto);
            <g:if test="${policia}">

            </g:if>
            <g:else>
            texto = $(this).data("prefijo") + ":${persona.latitud},${persona.longitud}";
            enviarMensaje(texto);
            </g:else>
//            console.log(texto);

            return false
        });
        $("#map-hide").click(function () {
            if ($("#map-container").hasClass("col-md-6")) {
                $("#map-container").removeClass("col-md-6").addClass("col-md-1");
                $(".map-hide").toggle();
                $(".divIzq").removeClass("col-md-6").addClass("col-md-11");
            } else {
                $("#map-container").removeClass("col-md-1").addClass("col-md-6");
                $(".map-hide").toggle();
                $(".divIzq").removeClass("col-md-11").addClass("col-md-6");
            }
        });
        $("#map-pop").click(function () {
            var ventana = window.open("${g.createLink(controller: control,action: 'ventanaMapa')}");
            $(".divIzq").removeClass("col-md-6").removeClass("col-md-11").addClass("col-md-12");
            $("#map-container").remove()
        });

        <g:if test="${policia}">
        $("#btnCom").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'mensajeComunidad', action:'listSelect_ajax')}",
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgMensajesComunidad",
                        title   : "<span class='text-verde'>Enviar Mensaje a la Comunidad</span>",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            }
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
            return false;
        });
        </g:if>

    });
</script>