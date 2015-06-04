<%--
  Created by IntelliJ IDEA.
  User: Luz
  Date: 3/15/2015
  Time: 12:20 AM
--%>

<%@ page import="arazu.proyectos.Funcion; arazu.inventario.Bodega; arazu.proyectos.Proyecto" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Proyecto</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="form" class="btn btn-default">
                    <i class="fa fa-file-o"></i> Crear
                </g:link>
            </div>

            <div class="btn-group pull-right col-md-3 col-sm-4">
                <div class="input-group">
                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <g:link controller="proyecto" action="list" class="btn btn-default btn-search">
                            <i class="fa fa-search"></i>&nbsp;
                        </g:link>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <g:sortableColumn property="nombre" title="Nombre"/>
                    <g:sortableColumn property="descripcion" title="Descripción"/>
                    <g:sortableColumn property="entidad" title="Entidad"/>
                    <g:sortableColumn property="fechaInicio" title="Fecha Inicio"/>
                    <g:sortableColumn property="fechaFin" title="Fecha Fin"/>
                    <th>Observaciones</th>
                </tr>
            </thead>
            <tbody>
                <g:if test="${proyectoInstanceCount > 0}">
                    <g:each in="${proyectoInstanceList}" status="i" var="proyectoInstance">
                        <g:set var="bodegas" value="${Bodega.countByProyecto(proyectoInstance)}"/>
                        <g:set var="funciones" value="${Funcion.countByProyecto(proyectoInstance)}"/>
                        <g:set var="personal" value="${proyectoInstance.personal.size()}"/>

                        <g:set var="bodegasActivas" value="${Bodega.countByProyectoAndActivo(proyectoInstance, 1)}"/>
                        <g:set var="tieneBodegasActivas" value="${proyectoInstance.fechaFin && proyectoInstance.fechaFin < new Date().clearTime() && bodegasActivas > 0}"/>
                        <tr data-id="${proyectoInstance.id}">
                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${proyectoInstance}" field="nombre"/></elm:textoBusqueda></td>
                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${proyectoInstance}" field="descripcion"/></elm:textoBusqueda></td>
                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${proyectoInstance}" field="entidad"/></elm:textoBusqueda></td>
                            <td><g:formatDate date="${proyectoInstance.fechaInicio}" format="dd-MM-yyyy"/></td>
                            <td><g:formatDate date="${proyectoInstance.fechaFin}" format="dd-MM-yyyy"/></td>
                            <td class="${bodegas == 0 || funciones == 0 || personal == 0 ? 'alert alert-danger' : ''} ${tieneBodegasActivas ? 'alert alert-warning' : ''} ">
                                <g:if test="${!tieneBodegasActivas}">
                                    <g:if test="${bodegas == 0}">
                                        <p>
                                            <g:link action="config" id="${proyectoInstance.id}" class="alert-link ">
                                                <i class="fa fa-archive"></i> No tiene una bodega asignada
                                            </g:link>
                                        </p>
                                    </g:if>
                                    <g:if test="${funciones == 0}">
                                        <p>
                                            <g:link action="config" id="${proyectoInstance.id}" class="alert-link ">
                                                <i class="fa fa-users"></i> No tiene responsables asignados
                                            </g:link>
                                        </p>
                                    </g:if>
                                    <g:if test="${personal == 0}">
                                        <p>
                                            <g:link controller="personalProyecto" action="asignarPersonal" id="${proyectoInstance.id}" class="alert-link ">
                                                <i class="fa flaticon-construction4"></i> No tiene personal asignado
                                            </g:link>
                                        </p>
                                    </g:if>
                                </g:if>
                                <g:else>
                                    <p>
                                        <a href="#" data-id="${proyectoInstance.id}" class="alert-link desactivarBodega">
                                            <i class="fa fa-archive"></i> No ha desactivado la bodega
                                        </a>
                                    </p>
                                </g:else>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="8">
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

        <elm:pagination total="${proyectoInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            function deleteProyecto(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Proyecto seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Proyecto");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'proyecto', action:'delete_ajax')}',
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

            $(function () {

                $("tbody>tr").contextMenu({
                    items  : {
                        header     : {
                            label  : "Acciones",
                            header : true
                        },
                        ver        : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'proyecto', action:'show')}/" + id;
                            }
                        },
                        editar     : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'proyecto', action:'form')}/" + id;
                            }
                        },
                        configurar : {
                            label  : "Configurar",
                            icon   : "fa fa-cogs",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'proyecto', action:'config')}/" + id;
                            }
                        },
                        personal   : {
                            label  : "Personal proyecto",
                            icon   : "fa flaticon-construction4",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'personalProyecto', action:'asignarPersonal')}/" + id;
                            }
                        }/*,
                         eliminar : {
                         label            : "Eliminar",
                         icon             : "fa fa-trash-o",
                         separator_before : true,
                         action           : function ($element) {
                         var id = $element.data("id");
                         deleteProyecto(id);
                         }
                         }*/
                    },
                    onShow : function ($element) {
                        $element.addClass("success");
                    },
                    onHide : function ($element) {
                        $(".success").removeClass("success");
                    }
                });

                $(".desactivarBodega").click(function () {
                    var id = $(this).data("id");
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'bodega', action:'desactivarUI_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            closeLoader();
                            bootbox.dialog({
                                id      : "dlgDesactivarBodega",
                                title   : "Desactivar Bodega",
                                message : msg,
                                buttons : {
                                    cancelar : {
                                        label     : "Cancelar",
                                        className : "btn-primary",
                                        callback  : function () {
                                        }
                                    },
                                    mover    : {
                                        label     : "<i class='fa fa-paper-plane-o'></i> Mover",
                                        className : "btn-success",
                                        callback  : function () {
                                            var data = {};
                                            $(".bdNew").each(function () {
                                                data[$(this).attr("name")] = $(this).val();
                                            });
                                            openLoader("Moviendo inventario");
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(controller:'bodega', action:'desactivar_ajax')}",
                                                data    : data,
                                                success : function (msg) {
                                                    var parts = msg.split("*");
                                                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                                    setTimeout(function () {
                                                        if (parts[0] == "SUCCESS") {
                                                            location.reload(true);
                                                        } else {
                                                            closeLoader();
                                                            return false;
                                                        }
                                                    }, 1000);
                                                }
                                            });
                                        }
                                    }
                                } //buttons
                            }); //dialog
                        } //success
                    }); //ajax
                    return false;
                });

            });
        </script>

    </body>
</html>
