<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Parámetros</title>

        <style type="text/css">
        .fa-ul li {
            margin : 5px;
        }

        .panel-title {
            font-size : 18px;
        }
        </style>
    </head>

    <body>

        <elm:container tipo="horizontal" titulo="Parámetros del Sistema">
            <div class="row">
                <div class="col-md-3">
                    <ul class="fa-ul">
                        <li>
                            <i class="fa-li fa fa-paint-brush text-info"></i>
                            <g:link class="over" controller="color" action="list">
                                Colores
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class="fa fa-paint-brush fa-2x"></i> Colores</h4>

                                <p>Permite registrar diferentes colores para la descripción de items de la bodega</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-street-view text-info"></i>
                            <g:link class="over" controller="cargo" action="list">
                                Cargos
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class=" fa fa-street-view fa-2x"></i> Cargos</h4>

                                <p>Permite registrar cargos para registrar funciones en los proyectos</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-question-circle text-info"></i>
                            <g:link class="over" controller="motivoSolicitud" action="list">
                                Motivos de solicitud
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class="fa fa-question-circle fa-2x"></i> Tipos de solicitud</h4>

                                <p>Permite registrar diferentes motivos de creación de solicitudes</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-file-archive-o text-info"></i>
                            <g:link class="over" controller="tipoSolicitud" action="list">
                                Tipos de solicitud
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class="fa fa-file-archive-o fa-2x"></i> Tipos de solicitud</h4>

                                <p>Muestra los diferentes tipos de solicitud</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-check-square-o text-info"></i>
                            <g:link class="over" controller="estadoSolicitud" action="list">
                                Estados de solicitud
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class="fa fa-check-square-o fa-2x "></i> Estados de solicitud</h4>

                                <p>Muestra los diferentes estados en los que puede estar una solicitud</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-server text-info"></i>
                            <g:link class="over" controller="unidad" action="list">
                                Unidades
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class=" fa fa-server fa-2x"></i> Unidades</h4>

                                <p>Permite registrar las unidades para el inventario</p>
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="col-md-9" id="divParametro">
                    ASFASDFASDF
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            $(function () {
                $(".over").click(function () {
                    var url = $(this).attr("href");
                    $.ajax({
                        type    : "POST",
                        url     : url,
                        success : function (msg) {
                            $("#divParametro").html(msg);
                        }
                    });
                    return false;
                });

            });
        </script>

    </body>
</html>