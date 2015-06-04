<%@ page import="arazu.proyectos.Proyecto" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!proyectoInstance}">
    <elm:notFound elem="Proyecto" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmProyecto" id="${proyectoInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Fecha Fin" claseField="col-sm-4">
                <elm:datepicker name="fechaFin" class="datepicker form-control " value="${proyectoInstance?.fechaFin}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
                <g:textField name="descripcion" required="" class="form-control  required" value="${proyectoInstance?.descripcion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Entidad" claseField="col-sm-6">
                <g:textField name="entidad" required="" class="form-control  required" value="${proyectoInstance?.entidad}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Fecha Inicio" claseField="col-sm-4">
                <elm:datepicker name="fechaInicio" class="datepicker form-control  required" value="${proyectoInstance?.fechaInicio}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Latitud" claseField="col-sm-2">
                <g:textField name="latitud" value="${fieldValue(bean: proyectoInstance, field: 'latitud')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Longitud" claseField="col-sm-2">
                <g:textField name="longitud" value="${fieldValue(bean: proyectoInstance, field: 'longitud')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" required="" class="form-control  required" value="${proyectoInstance?.nombre}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Zoom" claseField="col-sm-2">
                <g:textField name="zoom" value="${proyectoInstance.zoom}" class="digits form-control  required" required=""/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmProyecto").validate({
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
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormProyecto();
                return false;
            }
            return true;
        });
    </script>

</g:else>