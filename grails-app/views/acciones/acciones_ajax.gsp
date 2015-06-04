<%@ page import="arazu.seguridad.Sistema; arazu.seguridad.Permiso; arazu.seguridad.Modulo; arazu.seguridad.TipoAccion" %>

<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>
<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>

<table id="tblAcciones" class="table table-bordered table-condensed table-hover">
    <thead>
        <tr>
            <th width="10%">
                Permiso
                <a href="#" title="Guardar todos los permisos modificados" class="btn btn-save-perm btn-success btn-sm pull-right">
                    <i class="fa fa-save"></i>
                </a>
            </th>
            <th width="15%">Acción</th>
            <th width="15%">
                Nombre
                <a href="#" title="Guardar todos los nombre modificados" class="btn btn-save-desc btn-success btn-sm pull-right">
                    <i class="fa fa-save"></i>
                </a>
            </th>
            <th width="10%">Controlador</th>
            <th width="15%">Módulo
                <a href="#" title="Guardar todos los módulos modificados" class="btn btn-save-mod btn-success btn-sm pull-right">
                    <i class="fa fa-save"></i>
                </a>
            </th>
            <th width="15%">Sistema
                <a href="#" title="Guardar todos los sistemas modificados" class="btn btn-save-sis btn-success btn-sm pull-right">
                    <i class="fa fa-save"></i>
                </a>
            </th>
            <th width="8%">Tipo</th>
            <th width="7%">Orden</th>
            <th width="5%">Icono</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${acciones}" var="accion" status="i">
            <g:set var="esMenu" value="${accion.tipo.codigo == 'M'}"/>
            <g:set var="cantPermisos" value="${Permiso.countByAccionAndPerfil(accion, perfil)}"/>
            <tr class="${esMenu ? 'success' : 'info'}" style="${cantPermisos > 0 ? 'font-weight: bold' : ''}"
                data-nombre="${accion.descripcion}" data-orden="${accion.orden}" data-id="${accion.id}"
                data-icono="${accion.icono}">
                <td data-id="${accion.id}" class="text-center check ${cantPermisos > 0 ? 'checked' : ''}"
                    data-original="${cantPermisos > 0 ? 'checked' : 'unchecked'}">
                    <i class="fa ${cantPermisos > 0 ? 'fa-check-square-o' : 'fa-square-o'}"></i>
                </td>
                <td>
                    ${accion.nombre}
                </td>
                <td>
                    <input type="text" data-original="${accion.descripcion}" data-id="${accion.id}" class="form-control input-sm input-sm input-desc"
                           value="${accion.descripcion}" tabindex="${i + 1}"/>
                </td>
                <td>
                    ${accion.control.nombre}
                </td>
                <td>
                    <g:select name="modulo" from="${Modulo.list([sort: 'orden'])}" optionKey="id" optionValue="nombre" data-id="${accion.id}"
                              value="${accion.modulo.id}" class="form-control input-sm input-sm select-mod" data-original="${accion.modulo.id}"
                              tabindex="${i + 1 + acciones.size()}"/>
                </td>
                <td>
                    <g:select name="sistema" from="${Sistema.list([sort: 'orden'])}" optionKey="id" optionValue="nombre" data-id="${accion.id}"
                              value="${accion.sistemaId}" class="form-control input-sm input-sm select-sis" data-original="${accion.sistemaId}"
                              tabindex="${i + 2 + acciones.size()}" noSelection="[null: '- Todos -']"/>
                </td>
                <td>
                    <a href="#" class="btn btn-switch btn-xs ${esMenu ? 'btn-info' : 'btn-success'}" data-id="${accion.id}"
                       title="Cambiar a ${esMenu ? 'proceso' : 'menú'}" data-tipo="${accion.tipo.codigo}">
                        <i class="fa ${esMenu ? 'fa-cog' : 'fa-navicon'}"></i>
                    </a>
                    <span class="tipo-lbl">
                        ${accion.tipo.tipo}
                    </span>
                </td>
                <td class="text-right orden">
                    ${accion.orden}
                </td>
                <td class="text-right icono">
                    <g:if test="${accion.icono}">
                        <i class="${accion.icono}"></i>
                    </g:if>
                </td>
            </tr>
        </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $("#tblAcciones").fixedHeaderTable({
        height     : 320,
        autoResize : true,
        footer     : true
    });

    $('[title!=""]').qtip({
        style    : {
            classes : 'qtip-tipsy'
        },
        position : {
            my : "bottom center",
            at : "top center"
        }
    });

    $(".orden").click(function () {
        var $tr = $(this).parents("tr");
        var accion = $tr.data("nombre");
        var accionId = $tr.data("id");
        var orden = $tr.data("orden");
        bootbox.prompt({
            title    : "Cambiar orden de <span class='text-info'>" + accion + "</span>",
            value    : orden,
            class    : "modal-sm",
            type     : "number",
            callback : function (result) {
                if (result === null) {
                } else {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'acciones', action:'accionCambiarOrden_ajax')}",
                        data    : {
                            id    : accionId,
                            orden : result
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            closeLoader();
                            if (parts[0] == "SUCCESS") {
                                reload();
                            }
                        }
                    });
                }
            }
        });
    });

    $(".icono").click(function () {
        var $this = $(this);
        var $tr = $this.parents("tr");
        var accion = $tr.data("nombre");
        var accionId = $tr.data("id");
        var ic = $tr.data("icono");

        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'icono', action:'dlgIconos_ajax')}",
            data    : {
                selected : ic
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgIconos",
                    title   : "Cambiar ícono de " + accion,
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
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                var icono = $(".ic.selected").data("str");
                                openLoader();
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(controller:'acciones', action:'accionCambiarIcono_ajax')}",
                                    data    : {
                                        id    : accionId,
                                        icono : icono
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("*");
                                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                        closeLoader();
                                        if (parts[0] == "SUCCESS") {
                                            reload();
                                        }
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
    });

    $(".select-mod").change(function () {
        var $this = $(this);
        var valOrig = $.trim($this.data("original"));
        var val = $.trim($this.val());
        if (valOrig != val) {
            $this.parents("tr").addClass("warning");
            $this.addClass("select-changed");
        } else {
            $this.parents("tr").removeClass("warning");
            $this.removeClass("select-changed");
        }
    });

    $(".select-sis").change(function () {
        var $this = $(this);
        var valOrig = $.trim($this.data("original"));
        var val = $.trim($this.val());
        if (valOrig != val) {
            $this.parents("tr").addClass("warning");
            $this.addClass("select-changed");
        } else {
            $this.parents("tr").removeClass("warning");
            $this.removeClass("select-changed");
        }
    });

    $(".input-desc").blur(function () {
        var $this = $(this);
        var valOrig = $.trim($this.data("original"));
        var val = $.trim($this.val());
        if (valOrig != val) {
            $this.parents("tr").addClass("warning");
            $this.addClass("input-changed");
        } else {
            $this.parents("tr").removeClass("warning");
            $this.removeClass("input-changed");
        }
    });

    $(".btn-save-desc").click(function () {
        var data = {};
        $(".input-changed").each(function () {
            var $input = $(this);
            data["desc_" + $input.data("id")] = $input.val();
        });
        openLoader("Guardando");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'acciones', action:'accionCambiarNombre_ajax')}",
            data    : data,
            success : function (msg) {
                var parts = msg.split("*");
                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                closeLoader();
                if (parts[0] == "SUCCESS") {
                    $("tr.warning").removeClass("warning");
                    $(".input-changed").each(function () {
                        var $input = $(this);
                        $input.data("original", $input.val()).removeClass("input-changed");
                    });
                }
            }
        });
        return false;
    });

    $(".btn-save-mod").click(function () {
        var data = {};
        $(".select-changed").each(function () {
            var $input = $(this);
            data["mod_" + $input.data("id")] = $input.val();
        });
        openLoader("Guardando");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'acciones', action:'accionCambiarModulo_ajax')}",
            data    : data,
            success : function (msg) {
                var parts = msg.split("*");
                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                closeLoader();
                if (parts[0] == "SUCCESS") {
                    $(".select-changed").each(function () {
                        var $input = $(this);
                        $input.parents("tr").remove();
                    });
                }
            }
        });
        return false;
    });

    $(".btn-save-sis").click(function () {
        var data = {};
        $(".select-changed").each(function () {
            var $input = $(this);
            data["sis_" + $input.data("id")] = $input.val();
        });
        openLoader("Guardando");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'acciones', action:'accionCambiarSistema_ajax')}",
            data    : data,
            success : function (msg) {
                var parts = msg.split("*");
                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                closeLoader();
                if (parts[0] == "SUCCESS") {
                  reload();
                }
            }
        });
        return false;
    });

    $(".btn-switch").click(function () {
        var $this = $(this);
        var id = $this.data("id");
        var tipo = $this.data("tipo");
//            console.log(id, tipo);
        if (tipo == "M") {
            tipo = "P";
        } else if (tipo == "P") {
            tipo = "M";
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'acciones', action:'accionCambiarTipo_ajax')}",
            data    : {
                id   : id,
                tipo : tipo
            },
            success : function (msg) {
                var parts = msg.split("*");
                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                if (parts[0] == "SUCCESS") {
                    if (tipo == 'M') {
                        $this.parents("tr").removeClass("info").addClass("success");
                        $this.removeClass("btn-success").addClass("btn-info");
                        $this.attr("title", "Cambiar a proceso");
                        $this.find("i").removeClass("fa-navicon").addClass("fa-cog");
                        $this.data("tipo", "M");
                        $this.parents("td").find(".tipo-lbl").text("Menú");
                    } else {
                        $this.parents("tr").removeClass("success").addClass("info");
                        $this.removeClass("btn-info").addClass("btn-success");
                        $this.attr("title", "Cambiar a menú");
                        $this.find("i").removeClass("fa-cog").addClass("fa-navicon");
                        $this.data("tipo", "P");
                        $this.parents("td").find(".tipo-lbl").text("Proceso");
                    }
                }
            }
        });
        return false;
    });

    $(".check").click(function () {
        var $this = $(this);
        var original = $(this).data("original");
        if ($this.hasClass("checked")) {
            $this.removeClass("checked");
            $this.find("i").removeClass("fa-check-square-o").addClass("fa-square-o")
            if (original == "checked") {
                $this.parents("tr").addClass("warning");
            } else {
                $this.parents("tr").removeClass("warning");
            }
        } else {
            $this.addClass("checked");
            $this.find("i").removeClass("fa-square-o").addClass("fa-check-square-o")
            if (original == "unchecked") {
                $this.parents("tr").addClass("warning");
            } else {
                $this.parents("tr").removeClass("warning");
            }
        }
    });

    $(".btn-save-perm").click(function () {
        var perfil = "${perfil.id}";
        var data = {
            accion : ""
        };
        $(".checked").each(function () {
            data.accion += $(this).data("id") + ",";
        });
        data.perfil = "${perfil.id}";
        data.modulo = "${modulo.id}";
        openLoader();
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'acciones', action:'guardarPermisos_ajax')}",
            data    : data,
            success : function (msg) {
                $('.qtip').qtip('hide');
                var parts = msg.split("*");
                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
//                location.reload(true);
                closeLoader();
                reload();
            }
        });
        return false;
    });
</script>