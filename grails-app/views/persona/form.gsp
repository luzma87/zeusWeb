<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 11-Jun-15
  Time: 22:19
--%>

<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head lang="en">
        <meta charset="UTF-8">
        <meta name="layout" content="main"/>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script src="${g.resource(dir: 'js', file: 'markerwithlabel.js')}"></script>
        <script>
            var map;
            var marker;
            function placeMarker(lat, lng) {
                if (marker) {
                    marker.setMap(null);
                }

                var image = {
                    url    : '${resource(dir:"images/markers", file: "flag_32.png")}',
                    size   : new google.maps.Size(32, 32),
                    origin : new google.maps.Point(0, 0),
                    anchor : new google.maps.Point(10, 28)
                };

                marker = new google.maps.Marker({
                    position  : {
                        lat : lat,
                        lng : lng
                    },
                    map       : map,
                    animation : google.maps.Animation.DROP,
                    draggable : true,
                    icon      : image,
                    title     : "Ubicar proyecto aquí"
                });

                google.maps.event.addListener(marker, 'dragend', function (evt) {
                    $("#latitud").val(evt.latLng.lat());
                    $("#longitud").val(evt.latLng.lng());
                });
                $("#latitud").val(lat);
                $("#longitud").val(lng);
//                $("#zoom").val(map.getZoom());
            }

            function initialize() {
                var lat = -0.16481615;
                var lng = -78.47895741;
                var zoom = 15;
                <g:if test="${personaInstance.id}">
                lat = ${personaInstance.latitud};
                lng = ${personaInstance.longitud};
                </g:if>

                var mapOptions = {
                    center    : {
                        lat : lat,
                        lng : lng
                    },
                    zoom      : zoom,
                    mapTypeId : google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);

                google.maps.event.addListener(map, 'click', function (event) {
                    placeMarker(event.latLng.lat(), event.latLng.lng());
                });
                google.maps.event.addListener(map, 'zoom_changed', function (event) {
                    $("#zoom").val(map.getZoom());
                });

                <g:if test="${personaInstance.id}">
                placeMarker(lat, lng);
                </g:if>

            }
            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
        <title>Zeus - chat</title>
        <style type="text/css">
        .divIzq {
            height                    : 520px;
            border-bottom-left-radius : 5px;
            border-top-left-radius    : 5px;
            margin-right              : 5px;
            padding                   : 10px;
            margin-top                : 0;
            border                    : 1px solid #36579F;
        }

        .divDer {
            height                     : 520px;
            overflow                   : auto;
            border-bottom-right-radius : 5px;
            border-top-right-radius    : 5px;
            padding                    : 10px;
            border                     : 1px solid #36579F;
        }

        body {
            margin-bottom : 0 !important;
        }

        .labels {
            color            : #000000;
            background-color : white;
            font-family      : "Lucida Grande", "Arial", sans-serif;
            font-size        : 11px;
            font-weight      : bold;
            text-align       : center;
            width            : 60px;
            border           : 1px solid #36579F;
            border-radius    : 3px;
            white-space      : nowrap;
        }
        </style>
    </head>

    <body>
        <div class="row">
            <div class="col-md-6 divIzq" style="position:relative;">

                <g:form class="form-horizontal" name="frmPersona" id="${personaInstance?.id}"
                        role="form" action="save_ajax" method="POST">
                    <g:hiddenField name="longitud" value="${fieldValue(bean: personaInstance, field: 'longitud')}" class="number form-control  "/>
                    <g:hiddenField name="latitud" value="${fieldValue(bean: personaInstance, field: 'latitud')}" class="number form-control  "/>

                    <div class="form-group grupo">
                        <label for="nombre" class="col-sm-2 control-label">Nombres</label>

                        <div class="col-sm-10">
                            <g:textField name="nombre" maxlength="100" class="form-control " value="${personaInstance?.nombre}"/>
                        </div>
                    </div>

                    <div class="form-group grupo">
                        <label for="tipo" class="col-sm-2 control-label">Tipo</label>

                        <div class="col-sm-4">
                            %{--<g:textField name="tipo" maxlength="1" class="form-control " value="${personaInstance?.tipo}"/>--}%
                            <g:select name="tipo" from="${Persona.constraints.tipo.inList}" class="form-control " value="${personaInstance?.tipo}"
                                      valueMessagePrefix="persona.tipo"/>
                        </div>
                        <label for="cedula" class="col-sm-2 control-label">Cédula</label>

                        <div class="col-sm-4">
                            <g:textField name="cedula" maxlength="13" class="form-control " value="${personaInstance?.cedula}"/>
                        </div>
                    </div>

                    <div class="form-group grupo">
                        <label for="telefono" class="col-sm-2 control-label">Teléfono</label>

                        <div class="col-sm-4">
                            <g:textField name="telefono" maxlength="13" class="form-control " value="${personaInstance?.telefono}"/>
                        </div>
                        <label for="celular" class="col-sm-2 control-label">Celular</label>

                        <div class="col-sm-4">
                            <g:textField name="celular" maxlength="13" class="form-control " value="${personaInstance?.celular}"/>
                        </div>
                    </div>

                    <div class="form-group grupo">
                        <label for="email" class="col-sm-2 control-label">E-mail</label>

                        <div class="col-sm-4">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                <g:field type="email" name="email" maxlength="13" class="form-control  unique noEspacios" value="${personaInstance?.email}"/>
                            </div>
                        </div>

                        <label for="login" class="col-sm-2 control-label">Login</label>

                        <div class="col-sm-4">
                            <g:textField name="login" maxlength="100" required="" class="form-control  required unique noEspacios" value="${personaInstance?.login}"/>
                        </div>
                    </div>

                    <div class="form-group grupo">
                        <label for="direccion" class="col-sm-2 control-label">Dirección</label>

                        <div class="col-sm-10">
                            <g:textArea name="direccion" cols="40" rows="5" maxlength="500" class="form-control " value="${personaInstance?.direccion}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-success">
                                <i class="fa fa-floppy-o"></i> Guardar
                            </button>
                        </div>
                    </div>
                </g:form>

            </div>

            <div class="col-md-5 divDer" id="googleMap">
            </div>
        </div>

        <script type="text/javascript">

        </script>
    </body>
</html>