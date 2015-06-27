<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Ingreso</title>
        <meta name="layout" content="login"/>

        <style type="text/css">
        .servicio {
            margin-top : 0;
            font-size  : 18px
        }

        .titulo {
            color     : #006EB7;
            font-size : 20pt;
        }

        input.required {
            border-bottom : 1px solid #ddd;
            border-right  : 1px solid #ddd;
        }
        </style>
    </head>

    <body>
        <div class="row" style="margin-top: 20px;">
            <div class="col-md-12">
                <div class="panel-completo" style="height: auto;min-height: 10px">
                    <div class="row">
                        <div class="col-md-12" style="position: relative">
                            <img src="${resource(dir: 'images', file: 'logo_policia.png')}" height="60px">
                            <span class="titulo">Zeus - Policía Nacional</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 20px;padding: 20px">
            <div class="col-md-4 col-md-offset-1">
                <div class="panel-completo" style="height: 347px">
                    <g:form name="frmLogin" action="validar">
                        <div class="row">
                            <div class="col-md-12 titulo-panel" style="position: relative">
                                Sistema de monitoreo comunitario
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12">
                                <h1 style="margin-top: 0">Ingreso al sistema</h1>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12">
                                <label>Usuario</label>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12 grupo">
                                <div class="input-group">
                                    <g:textField name="user" class="form-control required" placeholder="Ingrese su usuario"/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-user"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12">
                                <label>Contraseña</label>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12 grupo">
                                <div class="input-group">
                                    <g:passwordField name="pass" class="form-control required" placeholder="Ingrese su contraseña"/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-lock"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12 text-right">
                                <a href="#" class="btn btn-verde" id="btnIngresar"
                                   data-loading-text="<i class='fa fa-spinner fa-spin'></i> Espere...">
                                    <i class="fa fa-sign-in"></i> Ingresar
                                </a>
                            </div>
                        </div>
                    </g:form>
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
                                        <h1 class="servicio">Encargar casa</h1>
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
                                        <h1 class="servicio">Servicio móvil</h1>
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
                                        <i class="fa fa-comment fa-3x"></i>
                                    </div>

                                    <div class="col-xs-8 text-right">
                                        <h1 class="servicio">Contáctenos</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <script type="text/javascript">
            $(function () {
                var $frm = $("#frmLogin");
                $frm.validate({
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
                        user : "Ingrese su usuario",
                        pass : "Ingrese su contraseña"
                    }
                });

                $("#btnIngresar").click(function () {
                    if ($frm.valid()) {
                        $(this).button('loading');
                        $frm.submit();
                    }
                    return false;
                });
            })
        </script>

    </body>
</html>