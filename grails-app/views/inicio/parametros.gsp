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
                <div class="col-md-4">
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
                            <i class="fa-li fa fa-car text-info"></i>
                            <g:link class="over" controller="tipoTrabajo" action="list">
                                Tipos de trabajo
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class=" fa fa-car fa-2x"></i> Tipos de trabajo</h4>

                                <p>Permite registrar los tipos de trabajo disponibles en las solicitudes de mantenimiento</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-calendar-o text-info"></i>
                            <g:link class="over" controller="tipoAsistencia" action="list">
                                Tipo de asistencia
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class=" fa fa-calendar-o fa-2x"></i> Tipo de asistencia</h4>

                                <p>Permite registrar los tipos de asistencia</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-trash-o text-info"></i>
                            <g:link class="over" controller="tipoDesecho" action="list">
                                Tipos de Desecho
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class=" fa fa-trash-o fa-2x"></i> Tipos de desecho</h4>

                                <p>Permite registrar los tipos de desecho disponibles en los egresos de desecho</p>
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
                        <li>
                            <i class="fa-li fa fa-connectdevelop text-info"></i>
                            <g:link class="over" controller="parametros" action="list">
                                Parámetros
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class=" fa fa-connectdevelop fa-2x"></i> Parámetros</h4>

                                <p>Permite modificar los parámetros globales, como los valores máximos que pueden autorizar los jefes</p>
                            </div>
                        </li>
                        <li>
                            <i class="fa-li fa fa-simplybuilt text-info"></i>
                            <g:link class="over" controller="sistema" action="list">
                                Sistemas
                            </g:link>

                            <div class="descripcion hidden">
                                <h4><i class=" fa fa-simplybuilt fa-2x"></i> Sistemas</h4>

                                <p>Muestra los diferentes sistemas en los que se van a agrupar las acciones del menú</p>
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="col-md-4">
                    <div class="panel panel-info right hidden">
                        <div class="panel-heading">
                            <h1 class="panel-title text-shadow"></h1>
                        </div>

                        <div class="panel-body">

                        </div>
                    </div>
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            $(function () {
                $(".over").hover(function () {
                    var $h4 = $(this).siblings(".descripcion").find("h4");
                    var $cont = $(this).siblings(".descripcion").find("p");
                    $(".right").removeClass("hidden").find(".panel-title").html($h4.html()).end().find(".panel-body").html($cont.html());
                }, function () {
                    $(".right").addClass("hidden");
                });
            });
        </script>

    </body>
</html>