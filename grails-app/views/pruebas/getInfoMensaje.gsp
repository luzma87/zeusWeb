<%@ page import="seguridad.Persona" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o" />
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPersona" id="${personaInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-7">
                <g:textField name="nombre" maxlength="100" class="form-control " value="${personaInstance?.nombre}" disabled=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Login" claseField="col-sm-7">
                <g:textField disabled="" name="login" maxlength="100" required="" class="form-control  required unique noEspacios" value="${personaInstance?.login}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Cedula" claseField="col-sm-7">
                <g:textField disabled="" name="cedula" maxlength="13" class="form-control " value="${personaInstance?.cedula}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Email" claseField="col-sm-7">
                <div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i></span><g:field disabled="" type="email" name="email" maxlength="13" class="form-control  unique noEspacios" value="${personaInstance?.email}"/></div>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Direccion" claseField="col-sm-7">
                <g:textArea disabled="" name="direccion" cols="40" rows="5" maxlength="500" class="form-control " value="${personaInstance?.direccion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Telefono" claseField="col-sm-7">
                <g:textField disabled="" name="telefono" maxlength="13" class="form-control " value="${personaInstance?.telefono}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Celular" claseField="col-sm-7">
                <g:textField disabled="" name="celular" maxlength="13" class="form-control " value="${personaInstance?.celular}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Tipo" claseField="col-sm-7">
                <g:textField disabled="" name="tipo" maxlength="1" class="form-control " value="${personaInstance?.tipo}"/>
            </elm:fieldRapido>

        </g:form>
    </div>

</g:else>