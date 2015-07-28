<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 027 27-Jul-15
  Time: 18:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Mi cuenta</title>
    </head>

    <body>
        <div class="row">
            <div class="col-md-4">
                <div class="panel-completo" style="height: 347px">
                    <g:form name="frmPass" action="cambiarPass_ajax">
                        <g:hiddenField name="user" value="user"/>
                        <div class="row">
                            <div class="col-md-12 titulo-panel" style="position: relative">
                                Cambiar mi contraseña
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12">
                                <label>Contraseña actual</label>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12 grupo">
                                <div class="input-group">
                                    <g:passwordField name="pass0" class="form-control inputField required"
                                                     placeholder="Ingrese su contraseña actual"/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-unlock"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12">
                                <label>Contraseña nueva</label>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12 grupo">
                                <div class="input-group">
                                    <g:passwordField name="pass" class="form-control inputField required"
                                                     placeholder="Ingrese su nueva contraseña"/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-lock"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12">
                                <label>Repita contraseña</label>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12 grupo">
                                <div class="input-group">
                                    <g:passwordField name="pass2" class="form-control inputField required"
                                                     placeholder="Repita su nueva contraseña"/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-lock"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row fila">
                            <div class="col-md-12 text-right">
                                <a href="#" class="btn btn-verde" id="btnSave"
                                   data-loading-text="<i class='fa fa-spinner fa-spin'></i> Espere...">
                                    <i class="fa fa-floppy-o"></i> Guardar
                                </a>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                var $frm = $("#frmPass");

                function doSave() {
                    if ($frm.valid()) {
                        $("#btnSave").button('loading');
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'persona', action:'cambiarPass_ajax')}',
                            data    : $frm.serialize(),
                            success : function (msg) {
                                var parts = msg.split("*");
                                $("#btnSave").button('reset');
                                log(parts[1], parts[0]); // log(msg, type, title, hide)
                            },
                            error   : function () {
                                $("#btnSave").button('reset');
                                log("Ha ocurrido un error interno", "Error");
                                closeLoader();
                            }
                        });
                    }
                }

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
                    rules          : {
                        pass0 : {
                            remote : {
                                url  : '${createLink(controller:'persona', action:'validar_pass_ajax')}',
                                type : "post"
                            }
                        },
                        pass2 : {
                            equalTo : "#pass"
                        }
                    },
                    messages       : {
                        pass0 : {
                            required : "Ingrese su contraseña actual",
                            remote   : "Su contraseña actual no concuerda"
                        },
                        pass  : "Ingrese su contraseña",
                        pass2 : {
                            required : "Repita su contraseña",
                            equalTo  : "Ingrese la misma contraseña"
                        }
                    }
                });

                $(".inputField").keyup(function (ev) {
                    if (ev.keyCode == 13) {
                        doSave();
                    }
                });

                $("#btnSave").click(function () {
                    doSave();
                    return false;
                });
            });
        </script>

    </body>
</html>