<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/12/14
  Time: 12:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="no-menu">
        <title>Entrada</title>
        <link href="${resource(dir: 'css', file: 'login.css')}" rel="stylesheet"/>
    </head>

    <body>

        <elm:message tipo="error" contenido="${flash.message}"/>

        <div class="row">
            <div class="col-md-3 col-md-offset-9 col-sm-5 col-xs-5 col-xs-offset-7">
                <div class="lzm-tab lzm-tab-left lzm-tab-primary " style="background: none">
                    <div class="lzm-tab-heading" style="background: none">
                        <a href="#" class="selected">Entrada</a>
                    </div>

                    <div class="lzm-tab-body" style="background: white">
                        <img class="img-login" src="${resource(dir: 'images', file: 'logo-login.png')}"/>

                        <g:form name="frmLogin" action="validar">
                            <div class="input-group input-login">
                                <g:textField name="user" autocomplete="off" class="form-control required noEspacios" placeholder="Usuario"/>
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                            </div>

                            <div class="input-group input-login">
                                <g:passwordField name="pass" class="form-control required" placeholder="Contraseña"/>
                                <span class="input-group-addon"><i class="fa fa-unlock-alt"></i></span>
                            </div>

                            <div class="text-right">
                                <a href="#" id="btn-login" class="btn btn-primary">
                                    Validar <i class="fa fa-unlock"></i>
                                </a>
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var $frm = $("#frmLogin");
            function doLogin() {
                if ($frm.valid()) {
                    $("#btn-login").replaceWith(spinner);
                    $frm.submit();
                }
            }

            $(function () {
                $("#user").focus();

                $frm.validate({
//                    validClass    : "text-success",
                    errorClass     : "text-danger",
                    errorPlacement : function (error, element) {
                        if (element.parent().hasClass("input-group")) {
                            error.insertAfter(element.parent());
                        } else {
                            error.insertAfter(element);
                        }
                        console.log("error ", error, element, element.parents(".input-group"));
                        element.parents(".input-group").addClass('has-error');
                    }/*,
                     success       : function (label) {
                     console.log("success ", label, label.parents(".input-group"));
                     label.hide();
                     label.prev().removeClass('has-error').addClass("has-success");
                     }*/
                });
                $("#btn-login").click(function () {
                    doLogin();
                });
                $frm.find("input").keyup(function (ev) {
                    if (ev.keyCode == 13) {
                        doLogin();
                    }
                })
            });

        </script>

    </body>
</html>