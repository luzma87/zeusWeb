<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Zeus</title>
    <meta name="layout" content="main"/>
</head>
<body>
<mn:barraTop titulo="Zeus - Inicio"></mn:barraTop>
<g:if test="${session.usuario.tipo!='P'}">
    <div class="row" style="margin-top: 50px">
        <div class="col-md-3 col-md-offset-1">
            <div class="card-verde card-inicio">
                <div class="row">
                    <div class="col-xs-4">
                        <i class="fa fa-wechat fa-5x"></i>
                    </div>
                    <div class="col-xs-8 text-right">
                        <h2 style="margin-top: 0px">Chat</h2>
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
                        <h2 style="margin-top: 0px">Servicios</h2>
                        <ul style="list-style: none">
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
                        <h2 style="margin-top: 0px">Parámetos</h2>
                        <p>Actualice sus datos personales y dirección</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:if>
<g:else>
    <div class="row" style="margin-top: 50px">
        <div class="col-md-3 col-md-offset-1">
            <div class="card-verde card-inicio">
                <div class="row">
                    <div class="col-xs-4">
                        <i class="fa fa-wechat fa-5x"></i>
                    </div>
                    <div class="col-xs-8 text-right">
                        <h2 style="margin-top: 0px">Chat</h2>
                        <ul style="list-style: none">
                            <li>Comunitario</li>
                            <li>Policías</li>
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
                        <h2 style="margin-top: 0px">Servicios</h2>
                        <ul style="list-style: none">
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
                        <i class="fa fa-users  fa-5x"></i>
                    </div>
                    <div class="col-xs-8 text-right">
                        <h2 style="margin-top: 0px">Usuarios</h2>
                        <p>Registro y actualización de usuarios</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 50px">
        <div class="col-md-3 col-md-offset-1">
            <div class="card-verde card-inicio">
                <div class="row">
                    <div class="col-xs-4">
                        <i class="fa fa-file-pdf-o fa-5x"></i>
                    </div>
                    <div class="col-xs-8 text-right">
                        <h2 style="margin-top: 0px">Reportes</h2>
                        <p>Reportes parametrizados</p>
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
                        <h2 style="margin-top: 0px">Incidentes</h2>
                        <p>Incidentes reportados, ubicados en un mapa</p>
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
                        <h2 style="margin-top: 0px">Mensajes</h2>
                        <p>Configuración de mensajes comunitarios</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 50px">
        <div class="col-md-3 col-md-offset-1">
            <div class="card-verde card-inicio">
                <div class="row">
                    <div class="col-xs-4">
                        <i class="fa fa-5x">4</i>
                    </div>
                    <div class="col-xs-8 text-right">
                        <h2 style="margin-top: 0px">Usuarios registrados</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:else>
</body>
</html>