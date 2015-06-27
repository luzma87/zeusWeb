<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Inicio</title>
    <meta name="layout" content="login" />
</head>
<body>
<div class="row" style="margin-top: 20px;">
    <div class="col-md-12" >
        <div class="panel-completo" style="height: auto;min-height: 10px">
            <div class="row">
                <div class="col-md-12" style="position: relative" >
                    <img src="${resource(dir:'images',file: 'logo_policia.png')}" height="60px">
                    <span style="color: #006EB7">Zeus - Policía Nacional</span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row" style="margin-top: 20px;padding: 20px">
    <div class="col-md-4 col-md-offset-1">
        <div class="panel-completo" style="height: 347px">
            <div class="row">
                <div class="col-md-12 titulo-panel" style="position: relative">
                   Sistema de monitoreo comunitario
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <h1 style="margin-top: 0px">Ingreso al sistema</h1>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <label>Usuario:</label>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <input type="text" class="form-control" placeholder="Ingrese su usuario">
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <label>Contraseña:</label>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <input type="password" class="form-control" placeholder="Ingrese su contraseña">
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12 text-right">
                    <a href="#" class="btn btn-verde">
                        <i class="fa fa-sign-in"></i> Ingresar
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 ">
        <div class="panel-completo" style="height: 347px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    ¿No estás registrado?
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sollicitudin enim sapien,
                        vel efficitur justo semper in. Nunc rhoncus leo non vestibulum eleifend. Duis faucibus,
                        sem nec convallis efficitur, eros lectus efficitur ex.
                    </p>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                   <i class="fa fa-sign-in fa-4x"></i>
                </div>
                <div class="col-md-9" style="font-size: 22px;line-height: 48px">
                    Registrarse
                </div>
            </div>

        </div>
    </div>
    <div class="col-md-3 ">
        <div class="panel-completo">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Servicios
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <div class="card-verde">
                        <div class="row fila">
                            <div class="col-xs-4">
                                <i class="fa fa-home fa-3x"></i>
                            </div>
                            <div class="col-xs-8 text-right">
                                <h1 style="margin-top: 0px;font-size: 18px">Encargar casa</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <div class="card-verde">
                        <div class="row fila">
                            <div class="col-xs-4">
                                <i class="fa fa-mobile fa-3x"></i>
                            </div>
                            <div class="col-xs-8 text-right">
                                <h1 style="margin-top: 0px;font-size: 18px">Servicio móvil</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <div class="card-verde">
                        <div class="row fila">
                            <div class="col-xs-4">
                                <i class="fa fa-wechat fa-3x"></i>
                            </div>
                            <div class="col-xs-8 text-right">
                                <h1 style="margin-top: 0px;font-size: 18px">Contáctenos</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>