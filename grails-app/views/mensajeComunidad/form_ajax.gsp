<%@ page import="mensajes.MensajeComunidad" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!mensajeComunidadInstance}">
    <elm:notFound elem="MensajeComunidad" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmMensajeComunidad" id="${mensajeComunidadInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2 text-default" label="Resumen" claseField="col-sm-6">
                <g:textField name="resumen" maxlength="30" required="" class="form-control  required" value="${mensajeComunidadInstance?.resumen}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2 text-default" label="Contenido" claseField="col-sm-6">
                <g:textArea name="contenido" required="" class="form-control  required" style="height: 150px;"
                            value="${mensajeComunidadInstance?.contenido}"/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmMensajeComunidad").validate({
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
                submitFormMensajeComunidad();
                return false;
            }
            return true;
        });
    </script>

</g:else>