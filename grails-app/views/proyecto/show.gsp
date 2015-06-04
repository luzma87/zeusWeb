<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 28/01/2015
  Time: 22:01
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Proyecto</title>

        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?language=es&key=AIzaSyDffD8MyvUA80jsioz1yh-o-iP6ZR4Prvc"></script>

        <style type="text/css">
        #map {
            height     : 350px;
            background : #6495ed;
            border     : double 5px #42619a;
        }
        </style>

    </head>

    <body>

        <g:if test="${!proyectoInstance}">
            <elm:message tipo="notFound">No se encontró elproyecto solicitado</elm:message>
        </g:if>
        <g:else>

            <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

            <!-- botones -->
            <div class="btn-toolbar toolbar">
                <div class="btn-group">
                    <g:link action="list" class="btn btn-default">
                        <i class="fa fa-list"></i> Lista de proyectos
                    </g:link>
                </div>
                <div class="btn-group">
                    <g:link action="form" id="${proyectoInstance.id}" class="btn btn-default">
                        <i class="fa fa-pencil"></i> Modificar
                    </g:link>
                    <g:link action="config" id="${proyectoInstance.id}" class="btn btn-default">
                        <i class="fa fa-cogs"></i> Configurar
                    </g:link>
                </div>
            </div>

            <elm:container tipo="horizontal" titulo="${proyectoInstance.nombre}">
                <div class="row">
                    <div class="col-md-6 col-sm-12">
                        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-10">
                            ${proyectoInstance?.nombre}
                        </elm:fieldRapido>

                        <elm:fieldRapido claseLabel="col-sm-2" label="Entidad" claseField="col-sm-10">
                            ${proyectoInstance?.entidad}
                        </elm:fieldRapido>

                        <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="F. Inicio" claseField1="col-sm-8"
                                              claseLabel2="col-sm-4" label2="F. Fin" claseField2="col-sm-8">
                            ${proyectoInstance?.fechaInicio?.format("dd-MM-yyyy")}
                            <hr/>
                            ${proyectoInstance?.fechaFin?.format("dd-MM-yyyy")}
                        </elm:fieldRapidoDoble>

                        <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-10">
                            ${proyectoInstance?.descripcion}
                        </elm:fieldRapido>
                    </div>

                    <div class="col-md-6 col-sm-12 corner-all" id="map">
                    </div>
                </div>
            </elm:container>

            <script type="text/javascript">
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
                        draggable : false,
                        icon      : image,
                        title     : "${proyectoInstance.nombre}"
                    });
                }

                function initialize() {
                    var lat = -2.074938318155129;
                    var lng = 282.54310888671876;
                    var zoom = 6;
                    <g:if test="${proyectoInstance.id}">
                    lat = ${proyectoInstance.latitud};
                    lng = ${proyectoInstance.longitud};
                    zoom = ${proyectoInstance.zoom};
                    </g:if>

                    var mapOptions = {
                        center : {
                            lat : lat,
                            lng : lng
                        },
                        zoom   : zoom
                    };
                    map = new google.maps.Map(document.getElementById('map'), mapOptions);

                    <g:if test="${proyectoInstance.id}">
                    placeMarker(lat, lng);
                    </g:if>

                }
                google.maps.event.addDomListener(window, 'load', initialize);
            </script>
        </g:else>
    </body>
</html>