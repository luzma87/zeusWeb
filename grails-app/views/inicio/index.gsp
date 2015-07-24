<%@ page import="mensajes.Mensaje; mensajes.Incidente" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Zeus</title>
        <meta name="layout" content="main"/>

        <style type="text/css">
        .lista {
            list-style   : none;
            padding-left : 0;
        }

        .marginTop {
            margin-top : 50px;
        }
        </style>

    </head>

    <body>
        <g:if test="${session.usuario.tipo != 'P'}">
            <div class="row marginTop">
                <div class="col-md-3 col-md-offset-1">
                    <div class="card-verde card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-wechat fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Chat</h2>

                                <p>Ingrese al chat comunitario</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-verde2 card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-cubes fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Servicios</h2>
                                <ul class="lista">
                                    <li>Móbiles</li>
                                    <li>Encargo</li>
                                    <li>Contactenos</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-naranja card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-cogs fa-spin fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Parámetos</h2>

                                <p>Actualice sus datos personales y dirección</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </g:if>
        <g:else>
            <div class="row marginTop">
                <div class="col-md-3 col-md-offset-1">
                    <div class="card-verde card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-wechat fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Chat</h2>
                                <ul class="lista">
                                    <li><g:link controller="chat" action="index">Comunitario</g:link></li>
                                    <li><g:link controller="chatPolicia" action="index">Policías</g:link></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-verde2 card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-cubes fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Servicios</h2>
                                <ul class="lista">
                                    <li>Móviles</li>
                                    <li>Encargo</li>
                                    <li>Contáctenos</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-naranja card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-users  fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Usuarios</h2>

                                <ul class="lista">
                                    <li><g:link controller="persona" action="list">Registro y actualización de usuarios</g:link></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row marginTop">
                <div class="col-md-3 col-md-offset-1">
                    <div class="card-verde card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-file-pdf-o fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Reportes</h2>

                                <ul class="lista">
                                    <li>Reportes parametrizados</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-verde2 card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-globe fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Incidentes</h2>

                                <ul class="lista">
                                    <li><g:link controller="mapa" action="index">Incidentes reportados, ubicados en un mapa</g:link></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-naranja card-inicio">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-cogs fa-rss fa-5x"></i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Mensajes</h2>

                                <ul class="lista">
                                    <li><g:link controller="mensajeComunidad" action="list">Configuración de mensajes comunitarios</g:link></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row marginTop">
                <div class="col-md-3 col-md-offset-1">
                    <div class="card-default">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-4x">${seguridad.Persona.count()}</i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Usuarios registrados</h2>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-default">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-4x">${Incidente.count()}</i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Incidentes reportados</h2>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-default">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-4x">${Mensaje.count()}</i>
                            </div>

                            <div class="col-xs-8 text-right">
                                <h2 style="margin-top: 0">Mensajes</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </g:else>
    </body>
</html>