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
        <title>${proyectoInstance.id ? "Modificar" : "Nuevo"} Proyecto</title>

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
                    <a href="#" id="btnSave" class="btn btn-primary">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                </div>
            </div>

            <elm:container tipo="horizontal" titulo="${proyectoInstance.id ? 'Modificar ' + proyectoInstance.nombre : 'Nuevo proyecto'}">
                <div class="row">
                    <div class="col-md-6 col-sm-12">
                        <g:form class="form-horizontal" name="frmProyecto" id="${proyectoInstance?.id}"
                                role="form" action="save_ignore" method="POST">

                            <g:hiddenField name="latitud" class="required" required=""/>
                            <g:hiddenField name="longitud"/>
                            <g:hiddenField name="zoom"/>

                            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-10">
                                <g:textField name="nombre" required="" class="form-control  required"
                                             value="${proyectoInstance?.nombre}" autocomplete="off"/>
                            </elm:fieldRapido>

                            <elm:fieldRapido claseLabel="col-sm-2" label="Entidad" claseField="col-sm-10">
                                <g:textField name="entidad" required="" class="form-control  required" value="${proyectoInstance?.entidad}"/>
                            </elm:fieldRapido>

                            <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="F. Inicio" claseField1="col-sm-8"
                                                  claseLabel2="col-sm-4" label2="F. Fin" claseField2="col-sm-8">
                                <elm:datepicker name="fechaInicio" class="datepicker form-control  required" value="${proyectoInstance?.fechaInicio}"/>
                                <hr/>
                                <elm:datepicker name="fechaFin" class="datepicker form-control " value="${proyectoInstance?.fechaFin}"/>
                            </elm:fieldRapidoDoble>

                            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-10">
                                <g:textArea style="height:100px;" name="descripcion" required="" class="form-control  required" value="${proyectoInstance?.descripcion}"/>
                            </elm:fieldRapido>
                        </g:form>
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
                    $("#zoom").val(map.getZoom());
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

                    google.maps.event.addListener(map, 'click', function (event) {
                        placeMarker(event.latLng.lat(), event.latLng.lng());
                    });
                    google.maps.event.addListener(map, 'zoom_changed', function (event) {
                        $("#zoom").val(map.getZoom());
                    });

                    <g:if test="${proyectoInstance.id}">
                    placeMarker(lat, lng);
                    </g:if>

                }
                google.maps.event.addDomListener(window, 'load', initialize);

                $(function () {
                    var $frm = $("#frmProyecto");

                    $("#latitud").val("");
                    $("#longitud").val("");
                    $("#zoom").val("");

                    $("#btnSave").click(function () {
                        if ($frm.valid()) {
                            openLoader("Guardando proyecto");
                            $frm.submit();
                        }
                    });

                    var validator = $frm.validate({
                        ignore         : [],
                        errorClass     : "help-block",
                        errorPlacement : function (error, element) {
                            if (element.parent().hasClass("input-group")) {
                                error.insertAfter(element.parent());
                            } else {
                                error.insertAfter(element);
                            }
                            element.parents(".grupo").addClass('has-error');
                        },
                        success        : function (label) {
                            label.parents(".grupo").removeClass('has-error');
                            label.remove();
                        },
                        messages       : {
                            latitud : {
                                required : "Ubique el proyecto en el mapa"
                            }
                        }
                    });
                    $(".form-control").keydown(function (ev) {
                        if (ev.keyCode == 13) {
                            submitFormProyecto();
                            return false;
                        }
                        return true;
                    });
                });
            </script>

        </g:else>

    </body>
</html>