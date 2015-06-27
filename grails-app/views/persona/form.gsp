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
                <g:if test="${personaInstance.id && personaInstance.latitud && personaInstance.longitud}">
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
        <title>Registro de usuario</title>
        <style type="text/css">
        .divIzq {
            height                    : 520px;
            border-bottom-left-radius : 5px;
            border-top-left-radius    : 5px;
            padding                   : 10px;
            margin-top                : 0;
        }

        .divDer {
            height                     : 520px;
            overflow                   : auto;
            border-bottom-right-radius : 5px;
            border-top-right-radius    : 5px;
            padding                    : 10px;
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
        %{--<mn:barraTop titulo="Registro de usuarios"/>--}%
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <div class="row fila">
            <div class="col-md-6 divIzq" style="position:relative;">
                <div class="panel-completo" style="padding: 5px">
                    <div class="row fila" style="margin-left: 0">
                        <div class="col-md-11 titulo-panel" style="position: relative">
                            Datos personales
                        </div>
                    </div>

                    <div class="row fila" style="margin-left: 0;height: 400px">
                        <div class="col-md-12">
                            <g:form class="form-horizontal" name="frmPersona" id="${personaInstance?.id}"
                                    role="form" action="save" method="POST">
                                <div class="grupo">
                                    <g:hiddenField name="longitud" value="${fieldValue(bean: personaInstance, field: 'longitud')}" class="number form-control required "/>
                                    <g:hiddenField name="latitud" value="${fieldValue(bean: personaInstance, field: 'latitud')}" class="number form-control required "/>
                                </div>

                                <div class="form-group">
                                    <label for="nombre" class="col-sm-2 control-label">Nombres</label>

                                    <div class="col-sm-10 grupo">
                                        <g:textField name="nombre" maxlength="100" class="form-control required" value="${personaInstance?.nombre}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="tipo" class="col-sm-2 control-label">Tipo</label>

                                    <div class="col-sm-4 grupo">
                                        <g:select name="tipo" from="${Persona.constraints.tipo.inList}" class="form-control required" value="${personaInstance?.tipo}"
                                                  valueMessagePrefix="persona.tipo"/>
                                    </div>
                                    <label for="cedula" class="col-sm-2 control-label">Cédula</label>

                                    <div class="col-sm-4 grupo">
                                        <g:textField name="cedula" maxlength="13" class="form-control required" value="${personaInstance?.cedula}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="telefono" class="col-sm-2 control-label">Teléfono</label>

                                    <div class="col-sm-4 grupo">
                                        <g:textField name="telefono" maxlength="13" class="form-control required" value="${personaInstance?.telefono}"/>
                                    </div>
                                    <label for="celular" class="col-sm-2 control-label">Celular</label>

                                    <div class="col-sm-4 grupo">
                                        <g:textField name="celular" maxlength="13" class="form-control required" value="${personaInstance?.celular}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="col-sm-2 control-label">E-mail</label>

                                    <div class="col-sm-4 grupo">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                            <g:field type="email" name="email" maxlength="50" class="form-control required unique noEspacios" value="${personaInstance?.email}"/>
                                        </div>
                                    </div>

                                    <label for="login" class="col-sm-2 control-label">Usuario</label>

                                    <div class="col-sm-4 grupo">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <i class="fa fa-user"></i>
                                            </span>
                                            <g:textField name="login" maxlength="100" required="" class="form-control required unique noEspacios" value="${personaInstance?.login}"/>
                                        </div>
                                    </div>
                                </div>

                                <g:if test="${!personaInstance.password}">
                                    <div class="form-group">
                                        <label for="pass" class="col-sm-2 control-label">Contraseña</label>

                                        <div class="col-sm-4 grupo">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                                <g:passwordField name="pass" maxlength="50" class="form-control required unique noEspacios"/>
                                            </div>
                                        </div>

                                        <label for="pass2" class="col-sm-2 control-label">Repita Contraseña</label>

                                        <div class="col-sm-4 grupo">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                                <g:passwordField name="pass2" maxlength="50" equalTo="#pass"
                                                                 class="form-control required unique noEspacios"/>
                                            </div>
                                        </div>
                                    </div>
                                </g:if>

                                <div class="form-group">
                                    <label for="direccion" class="col-sm-2 control-label">Dirección</label>

                                    <div class="col-sm-10 grupo">
                                        <g:textArea name="direccion" cols="40" rows="5" maxlength="500" class="form-control required" value="${personaInstance?.direccion}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <div class="btn-group" role="group">
                                            <g:link action="list" class="btn btn-default">Cancelar</g:link>
                                            <button type="submit" class="btn btn-verde" id="btnSubmit"
                                                    data-loading-text="<i class='fa fa-spinner fa-spin'></i> Espere...">
                                                <i class="fa fa-floppy-o"></i> Guardar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 divDer" id="map-container">
                <div class="panel-completo" style="padding: 5px">
                    <div class="row fila" style="margin-left: 0">
                        <div class="col-md-11 titulo-panel" style="position: relative">
                            <span class="map-hide">Ubicación</span>

                        </div>
                    </div>

                    <div class="" id="googleMap" style="margin-top: 5px;height: 400px">

                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">

            $(function () {
                $("#frmPersona").validate({
                    errorClass     : "help-block",
                    ignore         : [],
                    errorPlacement : function (error, element) {
                        if (element.attr("name") == "latitud" || element.attr("name") == "longitud") {
                            error.insertAfter("#latitud");
                        } else {
                            if (element.parent().hasClass("input-group")) {
                                error.insertAfter(element.parent());
                            } else {
                                error.insertAfter(element);
                            }
                        }
                        element.parents(".grupo").addClass('has-error');
                    },
                    submitHandler  : function (form) {
                        $("#btnSubmit").button('loading');
                        form.submit();
                    },
                    success        : function (label) {
                        label.parents(".grupo").removeClass('has-error');
                        label.remove();
                    },
                    groups         : {
                        ubicacion : "latitud longitud"
                    },
                    rules          : {
                        login : {
                            remote : {
                                url  : "${createLink(controller:'persona', action: 'validar_unique_login_ajax')}",
                                type : "post",
                                data : {
                                    id : "${personaInstance?.id}"
                                }
                            }
                        },
                        email : {
                            remote : {
                                url  : "${createLink(controller:'persona', action: 'validar_unique_email_ajax')}",
                                type : "post",
                                data : {
                                    id : "${personaInstance?.id}"
                                }
                            }
                        }
                    },
                    messages       : {
                        latitud   : {
                            required : "Ubique la persona en el mapa"
                        },
                        nombre    : {
                            required : "Ingrese el nombre"
                        },
                        cedula    : {
                            required : "Ingrese el número de cédula"
                        },
                        telefono  : {
                            required : "Ingrese el número de teléfono"
                        },
                        celular   : {
                            required : "Ingrese el número de celular"
                        },
                        login     : {
                            required : "Ingrese el usuario",
                            remote   : "Ya existe el usuario"
                        },
                        email     : {
                            required : "Ingrese el e-mail",
                            remote   : "Ya existe el email"
                        },
                        pass      : {
                            required : "Ingrese la contraseña"
                        },
                        pass2     : {
                            required : "Ingrese nuevamente la contraseña",
                            equalTo  : "Ingrese nuevamente la contraseña"
                        },
                        direccion : {
                            required : "Ingrese la dirección"
                        }
                    }
                });
            })
        </script>
    </body>
</html>