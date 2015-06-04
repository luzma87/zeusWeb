<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 28/01/2015
  Time: 22:01
--%>

<%@ page import="arazu.parametros.TipoUsuario; arazu.parametros.Cargo; arazu.seguridad.Persona; arazu.proyectos.Proyecto" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Configurar Proyecto</title>

        <style type="text/css">
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
                    <g:link action="show" id="${proyectoInstance.id}" class="btn btn-default">
                        <i class="fa fa-search"></i> Datos del proyecto
                    </g:link>
                </div>
            </div>

            <g:set var="bodegaIn" value="${bodegas.size() == 0 || params.b == '1'}"/>
            <g:set var="maxChars" value="${1023 - 80}"/>
            <g:set var="maxChars" value="${maxChars <= 0 ? 0 : maxChars}"/>

            <g:set var="responsablesBodega" value="${Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo('RSBD'))}"/>

            <elm:container tipo="horizontal" titulo="${proyectoInstance.nombre}: configuración">
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" style="margin-top: 15px;">
                    <div class="panel panel-info">
                        <div class="panel-heading" role="tab" id="headingOne">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"
                                   aria-expanded="${bodegaIn ? 'true' : 'false'}" aria-controls="collapseOne">
                                    <i class="fa fa-archive"></i> Bodega
                                </a>
                            </h4>
                        </div>

                        <div id="collapseOne" class="panel-collapse collapse ${bodegaIn ? 'in' : ''}" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body">
                                <g:if test="${bodegas.size() == 0}">
                                    <div class="alert alert-warning">
                                        No tiene una bodega asignada
                                    </div>

                                    <g:form class="form-horizontal" name="frmBodega" role="form"
                                            controller="bodega" action="save_ajax" method="POST">
                                        <g:hiddenField name="proyecto.id" value="${proyectoInstance.id}"/>

                                        <div class="form-group keeptogether">
                                            <span class="grupo">
                                                <label class="col-sm-1 control-label">Proyecto</label>

                                                <div class="col-sm-3">
                                                    <p class="form-control-static">
                                                        ${proyectoInstance.nombre}
                                                    </p>
                                                </div>
                                            </span>

                                            <span class="grupo">
                                                <label class="col-sm-1 control-label">Responsable</label>

                                                <div class="col-sm-2">
                                                    <g:select id="responsable.id" name="responsable.id"
                                                              from="${responsablesBodega}" optionKey="id" required=""
                                                              class="many-to-one form-control required bodega"/>
                                                </div>
                                            </span>

                                            <span class="grupo">
                                                <label class="col-sm-1 control-label">Suplente</label>

                                                <div class="col-sm-2">
                                                    <g:select id="suplente.id" name="suplente.id"
                                                              from="${responsablesBodega}" optionKey="id"
                                                              noSelection="['': '-- Ninguno --']"
                                                              class="many-to-one form-control bodega"/>
                                                </div>
                                            </span>

                                            <span class="grupo">
                                                <label class="col-sm-1 control-label">Activa</label>

                                                <div class="col-sm-1">
                                                    <g:select name="activo" from="[1: 'Sí', 0: 'No']" class="form-control required bodega" required=""
                                                              optionKey="key" optionValue="value"/>
                                                </div>
                                            </span>
                                        </div>

                                        <div class="form-group keeptogether">
                                            <span class="grupo">
                                                <label class="col-sm-1 control-label">Descripción</label>

                                                <div class="col-sm-5">
                                                    <g:textField name="descripcion" maxlength="50" class="form-control required bodega" required=""
                                                                 value="Bodega de ${proyectoInstance.nombre.size() <= 40 ? proyectoInstance.nombre : proyectoInstance.nombre[0..39]}"/>
                                                </div>
                                            </span>
                                            <span class="grupo">
                                                <label class="col-sm-1 control-label">Observaciones</label>

                                                <div class="col-sm-5">
                                                    <g:textArea name="observaciones" cols="40" rows="5" maxlength="${maxChars}" class="form-control bodega"/>
                                                </div>
                                            </span>
                                        </div>
                                        <a href="#" class="btn btn-primary pull-right" id="btnSaveBodega">
                                            <i class="fa fa-save"></i> Guardar
                                        </a>
                                    </g:form>
                                </g:if>
                                <g:else>
                                    <g:each in="${bodegas}" var="bodega">
                                        <div class="alert alert-info">
                                            <div class="row">
                                                <div class="col-sm-1 show-label">
                                                    Proyecto
                                                </div>

                                                <div class="col-sm-5">
                                                    ${bodega?.proyecto?.encodeAsHTML()}
                                                </div>

                                                <div class="col-sm-1 show-label">
                                                    Responsables
                                                </div>

                                                <div class="col-sm-3">
                                                    <strong>${bodega?.responsable?.encodeAsHTML()}</strong>
                                                    <g:if test="${bodega.suplente}">
                                                        , ${bodega?.suplente?.encodeAsHTML()}
                                                    </g:if>
                                                </div>

                                                <div class="col-sm-1 show-label">
                                                    Activa
                                                </div>

                                                <div class="col-sm-1">
                                                    <g:formatBoolean boolean="${bodega.activo == 1}" true="Sí" false="No"/>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <g:if test="${bodega.descripcion}">
                                                    <div class="col-sm-1 show-label">
                                                        Descripción
                                                    </div>

                                                    <div class="col-sm-5">
                                                        <g:fieldValue bean="${bodega}" field="descripcion"/>
                                                    </div>
                                                </g:if>

                                                <g:if test="${bodega.observaciones}">
                                                    <div class="col-sm-1 show-label">
                                                        Observaciones
                                                    </div>

                                                    <div class="col-sm-5" style="height: 100px; overflow-x: hidden; overflow-y: auto;">
                                                        ${bodega.observaciones}
                                                    </div>
                                                </g:if>
                                            </div>

                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <a href="#" class="btn btn-info btn-sm btnAddObs" data-id="${bodega.id}">
                                                        <i class="fa fa-pencil-square-o"></i> Agregar observaciones
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </g:each>
                                </g:else>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-info">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"
                                   aria-expanded="${bodegaIn ? 'false' : 'true'}" aria-controls="collapseTwo">
                                    <i class="fa fa-users"></i>  Responsables
                                </a>
                            </h4>
                        </div>

                        <div id="collapseTwo" class="panel-collapse collapse ${bodegaIn ? '' : 'in'}" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <div class="alert alert-success">
                                    <g:form class="form-inline" name="frmFuncion" role="form"
                                            controller="funcion" action="save_ajax" method="POST">
                                        <g:hiddenField name="proyecto.id" value="${proyectoInstance.id}"/>
                                        <div class="form-group">
                                            <label for="persona">Persona</label>
                                            <g:select id="persona" name="persona.id" from="${Persona.list([sort: 'apellido'])}" optionKey="id" required="" class="many-to-one form-control funcion"/>
                                        </div>

                                        <div class="form-group">
                                            <label for="cargo">Cargo</label>
                                            <g:select id="cargo" name="cargo.id" from="${Cargo.list([sort: 'descripcion'])}"
                                                      optionKey="id" required="" class="many-to-one form-control funcion"/>
                                        </div>

                                        <a href="#" class="btn btn-success" title="Agregar" id="btnAddFuncion">
                                            <i class="fa fa-plus"></i>
                                        </a>
                                    </g:form>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6" id="divTablaFunciones">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </elm:container>

            <script type="text/javascript">
                function submitFormBodega() {
                    var $form = $("#frmBodega");
                    var $btn = $("#btnSaveBodega");
                    if ($form.valid()) {
                        $btn.replaceWith(spinner);
                        openLoader("Guardando Bodega");
                        $.ajax({
                            type    : "POST",
                            url     : $form.attr("action"),
                            data    : $form.serialize(),
                            success : function (msg) {
                                spinner.replaceWith($btn);
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                setTimeout(function () {
                                    if (parts[0] == "SUCCESS") {
                                        location.reload(true);
                                    } else {
                                        closeLoader();
                                    }
                                }, 1000);
                            },
                            error   : function () {
                                log("Ha ocurrido un error interno", "Error");
                                closeLoader();
                            }
                        });
                    } else {
                        return false;
                    } //else
                }

                function submitFormFuncion() {
                    var $form = $("#frmFuncion");
                    var $btn = $("#btnAddFuncion");
                    if ($form.valid()) {

                        var perId = $("#persona").val();
                        var carId = $("#cargo").val();

                        var finds = $("#tb_funciones").find(".pr_" + perId + ".cr_" + carId);
                        if (finds.length == 0) {
                            $btn.hide().after(spinner);
                            $.ajax({
                                type    : "POST",
                                url     : $form.attr("action"),
                                data    : $form.serialize(),
                                success : function (msg) {
                                    spinner.remove();
                                    $btn.show();
                                    var parts = msg.split("*");
                                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                    if (parts[0] == "SUCCESS") {
                                        cargarFunciones();
                                    }
                                },
                                error   : function () {
                                    spinner.remove();
                                    $btn.show();
                                    log("Ha ocurrido un error interno", "Error");
                                    closeLoader();
                                }
                            });
                        } else {
                            finds.effect("highlight", 800);
                        }
                    }
                }

                function cargarFunciones() {
                    $("#divTablaFunciones").html(spinnerSquare64);
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller: 'funcion', action: 'list_ajax')}/${proyectoInstance.id}",
                        success : function (msg) {
                            $("#divTablaFunciones").html(msg);
                        },
                        error   : function () {
                            log("Ha ocurrido un error interno", "Error");
                        }
                    });
                }

                function deleteFuncion(itemId, $btn) {
                    $btn.hide().after(spinner);
                    $.ajax({
                        type    : "POST",
                        url     : '${createLink(controller:'funcion', action:'delete_ajax')}',
                        data    : {
                            id : itemId
                        },
                        success : function (msg) {
                            $btn.show();
                            spinner.remove();
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                cargarFunciones();
                            }
                        },
                        error   : function () {
                            log("Ha ocurrido un error interno", "Error");
                            $btn.show();
                            spinner.remove();
                        }
                    });
                }

                $(function () {
                    cargarFunciones();

                    $("#frmBodega").validate({
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
                            "suplente.id" : {
                                notEqualTo : '#responsable\\.id'
                            }
                        },
                        messages       : {
                            "suplente.id" : {
                                notEqualTo : 'El suplente no puede ser el mismo que el responsable'
                            }
                        }
                    });
                    $("#frmFuncion").validate({
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
                        }

                    });
                    $(".funcion").keydown(function (ev) {
                        if (ev.keyCode == 13) {
                            submitFormFuncion();
                            return false;
                        }
                        return true;
                    });

                    $(".bodega").keydown(function (ev) {
                        if (ev.keyCode == 13) {
                            submitFormBodega();
                            return false;
                        }
                        return true;
                    });

                    $("#btnSaveBodega").click(function () {
                        submitFormBodega();
                        return false;
                    });
                    $("#btnAddFuncion").click(function () {
                        submitFormFuncion();
                        return false;
                    });

                    $(".btnAddObs").click(function () {
                        var id = $(this).data("id");
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(controller:'bodega', action:'agregarObservaciones_ajax')}",
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                var b = bootbox.dialog({
                                    title   : "Agregar observaciones",
                                    message : msg,
                                    buttons : {
                                        cancelar : {
                                            label     : "Cancelar",
                                            className : "btn-primary",
                                            callback  : function () {
                                            }
                                        },
                                        guardar  : {
                                            id        : "btnSave",
                                            label     : "<i class='fa fa-save'></i> Guardar",
                                            className : "btn-success",
                                            callback  : function () {
                                                openLoader("Guardando observaciones");
                                                $.ajax({
                                                    type    : "POST",
                                                    url     : "${createLink(controller:'bodega', action:'guardarObservaciones_ajax')}",
                                                    data    : {
                                                        id  : id,
                                                        obs : $.trim($("#observaciones").val())
                                                    },
                                                    success : function (msg) {
                                                        var parts = msg.split("*");
                                                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                                        setTimeout(function () {
                                                            if (parts[0] == "SUCCESS") {
                                                                location.href = "${createLink(action:'config')}/${proyectoInstance.id}?b=1";
                                                            } else {
                                                                closeLoader();
                                                                return false;
                                                            }
                                                        }, 1000);
                                                    },
                                                    error   : function () {
                                                        closeLoader();
                                                        log("HA ocurrido un error interno", "error");
                                                    }
                                                });
                                            } //callback
                                        } //guardar
                                    } //buttons
                                }); //dialog
                                setTimeout(function () {
                                    b.find(".form-control").first().focus()
                                }, 500);
                            } //success
                        }); //ajax
                        return false;
                    });
                });

            </script>
        </g:else>
    </body>
</html>