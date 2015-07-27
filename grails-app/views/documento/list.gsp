<%@ page import="documentos.Documento" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Documentos</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <div class="row">
            <div class="col-md-12">
                <div class="panel-completo" style="padding: 5px">
                    <div class="row fila" style="margin-left: 0">
                        <div class="col-md-11 titulo-panel">
                            Documentos
                        </div>
                    </div>

                    <div class="row fila" style="margin-left: 0">

                        <!-- botones -->
                        <div class="btn-toolbar toolbar">
                            <div class="btn-group">
                                <a href="#" class="btn btn-verde btnCrear">
                                    <i class="fa fa-file-o"></i> Crear
                                </a>
                            </div>

                            <div class="btn-group pull-right col-md-3">
                                <div class="input-group">
                                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                                    <span class="input-group-btn">
                                        <g:link controller="documento" action="list" class="btn btn-verde btn-search">
                                            <i class="fa fa-search"></i>&nbsp;
                                        </g:link>
                                    </span>
                                </div><!-- /input-group -->
                            </div>
                        </div>
                    </div>

                    <div class="row fila">
                        <div class="col-md-12">
                            <table class="table table-condensed table-bordered table-striped table-hover verde">
                                <thead>
                                    <tr>

                                        <g:sortableColumn property="nombre" title="Nombre"/>

                                        <g:sortableColumn property="descripcion" title="Descripcion"/>

                                    </tr>
                                </thead>
                                <tbody>
                                    <g:if test="${documentoInstanceCount > 0}">
                                        <g:each in="${documentoInstanceList}" status="i" var="documentoInstance">
                                            <tr data-id="${documentoInstance.id}">

                                                <td>${documentoInstance.nombre}</td>

                                                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${documentoInstance}" field="descripcion"/></elm:textoBusqueda></td>

                                            </tr>
                                        </g:each>
                                    </g:if>
                                    <g:else>
                                        <tr class="danger">
                                            <td class="text-center" colspan="2">
                                                <g:if test="${params.search && params.search != ''}">
                                                    No se encontraron resultados para su búsqueda
                                                </g:if>
                                                <g:else>
                                                    No se encontraron registros que mostrar
                                                </g:else>
                                            </td>
                                        </tr>
                                    </g:else>
                                </tbody>
                            </table>

                            <elm:pagination total="${documentoInstanceCount}" params="${params}"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var id = null;
            function submitFormDocumento() {
                var $form = $("#frmDocumento");
                var $btn = $("#dlgCreateEditDocumento").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Documento");
                    $.ajax({
                        type    : "POST",
                        url     : $form.attr("action"),
                        data    : $form.serialize(),
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            setTimeout(function () {
                                if (parts[0] == "SUCCESS") {
                                    location.reload(true);
                                } else {
                                    spinner.replaceWith($btn);
                                    closeLoader();
                                    return false;
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
            function deleteDocumento(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Documento seleccionado? Esta acción no se puede deshacer.</p>",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-trash-o'></i> Eliminar",
                            className : "btn-danger",
                            callback  : function () {
                                openLoader("Eliminando Documento");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'documento', action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("*");
                                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "SUCCESS") {
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 1000);
                                        } else {
                                            closeLoader();
                                        }
                                    },
                                    error   : function () {
                                        log("Ha ocurrido un error interno", "Error");
                                        closeLoader();
                                    }
                                });
                            }
                        }
                    }
                });
            }
            function createEditDocumento(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'documento', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id    : "dlgCreateEditDocumento",
                            title : title + " Documento",

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
                                        return submitFormDocumento();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit

            $(function () {

                $(".btnCrear").click(function () {
                    createEditDocumento();
                    return false;
                });

                $("tbody>tr").contextMenu({
                    items  : {
                        header   : {
                            label  : "Acciones",
                            header : true
                        },
                        ver      : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function ($element) {
                                var id = $element.data("id");
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(controller:'documento', action:'show_ajax')}",
                                    data    : {
                                        id : id
                                    },
                                    success : function (msg) {
                                        bootbox.dialog({
                                            title : "Ver Documento",

                                            message : msg,
                                            buttons : {
                                                ok : {
                                                    label     : "Aceptar",
                                                    className : "btn-primary",
                                                    callback  : function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                createEditDocumento(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deleteDocumento(id);
                            }
                        }
                    },
                    onShow : function ($element) {
                        $element.addClass("success");
                    },
                    onHide : function ($element) {
                        $(".success").removeClass("success");
                    }
                });
            });
        </script>

    </body>
</html>
