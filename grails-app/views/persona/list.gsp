<%@ page import="seguridad.Persona" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Persona</title>
    </head>

    <body>
        %{--<mn:barraTop titulo="Usuarios"/>--}%
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <div class="row">
            <div class="col-md-12">
                <div class="panel-completo" style="padding: 5px">
                    <div class="row fila" style="margin-left: 0px">
                        <div class="col-md-11 titulo-panel">
                            Lista de usuarios
                        </div>
                    </div>

                    <div class="row fila" style="margin-left: 0px">
                        <div class="btn-toolbar toolbar">
                            <div class="btn-group">
                                <g:link action="form" class="btn btn-verde btnCrear">
                                    <i class="fa fa-file-o"></i> Crear
                                </g:link>
                            </div>

                            <div class="btn-group pull-right col-md-3">
                                <div class="input-group">
                                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                                    <span class="input-group-btn">
                                        <g:link controller="persona" action="list" class="btn btn-verde btn-search">
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

                                        <g:sortableColumn property="login" title="Login"/>

                                        <g:sortableColumn property="nombre" title="Nombre"/>

                                        <g:sortableColumn property="cedula" title="Cedula"/>

                                        <g:sortableColumn property="email" title="Email"/>

                                        <g:sortableColumn property="direccion" title="Direccion"/>

                                        <g:sortableColumn property="telefono" title="Telefono"/>

                                        <g:sortableColumn property="celular" title="Celular"/>

                                    </tr>
                                </thead>
                                <tbody>
                                    <g:if test="${personaInstanceCount > 0}">
                                        <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                                            <tr data-id="${personaInstance.id}">

                                                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${personaInstance}" field="login"/></elm:textoBusqueda></td>

                                                <td><elm:textoBusqueda busca="${params.search}">${personaInstance.nombre}</elm:textoBusqueda></td>

                                                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${personaInstance}" field="cedula"/></elm:textoBusqueda></td>

                                                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${personaInstance}" field="email"/></elm:textoBusqueda></td>

                                                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${personaInstance}" field="direccion"/></elm:textoBusqueda></td>

                                                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${personaInstance}" field="telefono"/></elm:textoBusqueda></td>

                                                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${personaInstance}" field="celular"/></elm:textoBusqueda></td>

                                            </tr>
                                        </g:each>
                                    </g:if>
                                    <g:else>
                                        <tr class="danger">
                                            <td class="text-center" colspan="12">
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

                            <elm:pagination total="${personaInstanceCount}" params="${params}"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <script type="text/javascript">

            function deletePersona(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Persona seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Persona");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'persona', action:'delete_ajax')}',
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
                                    url     : "${createLink(controller:'persona', action:'show_ajax')}",
                                    data    : {
                                        id : id
                                    },
                                    success : function (msg) {
                                        bootbox.dialog({
                                            title : "Ver Persona",

                                            class : "modal-lg",

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
                                location.href = "${createLink(action:'form')}/" + id
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deletePersona(id);
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
