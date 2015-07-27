<%@ page import="seguridad.Persona" %>

<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">
        <div class="row">
            <div class="col-md-12 show-label">
                <h3>Datos personales</h3>
            </div>

            <div class="col-md-6">
                <g:if test="${personaInstance?.tipo}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            Tipo
                        </div>

                        <div class="col-sm-10">
                            <g:message code="persona.tipo.${personaInstance.tipo}"/>
                        </div>

                    </div>
                </g:if>

                <g:if test="${personaInstance?.nombre}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            Nombre
                        </div>

                        <div class="col-sm-10">
                            <g:fieldValue bean="${personaInstance}" field="nombre"/>
                        </div>

                    </div>
                </g:if>

                <g:if test="${personaInstance?.login}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            Login
                        </div>

                        <div class="col-sm-10">
                            <g:fieldValue bean="${personaInstance}" field="login"/>
                        </div>

                    </div>
                </g:if>

                <g:if test="${personaInstance?.cedula}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            Cédula
                        </div>

                        <div class="col-sm-10">
                            <g:fieldValue bean="${personaInstance}" field="cedula"/>
                        </div>

                    </div>
                </g:if>

                <g:if test="${personaInstance?.email}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            E-mail
                        </div>

                        <div class="col-sm-10">
                            <g:fieldValue bean="${personaInstance}" field="email"/>
                        </div>

                    </div>
                </g:if>

                <g:if test="${personaInstance?.direccion}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            Dirección
                        </div>

                        <div class="col-sm-10">
                            <g:fieldValue bean="${personaInstance}" field="direccion"/>
                        </div>

                    </div>
                </g:if>

                <g:if test="${personaInstance?.telefono}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            Teléfono
                        </div>

                        <div class="col-sm-10">
                            <g:fieldValue bean="${personaInstance}" field="telefono"/>
                        </div>

                    </div>
                </g:if>

                <g:if test="${personaInstance?.celular}">
                    <div class="row">
                        <div class="col-sm-2 show-label">
                            Celular
                        </div>

                        <div class="col-sm-10">
                            <g:fieldValue bean="${personaInstance}" field="celular"/>
                        </div>

                    </div>
                </g:if>
            </div>
        </div>

        <g:if test="${personaInstance.documentos.size() > 0}">
            <div class="row">
                <div class="col-md-12 show-label">
                    <h3>Documentos entregados</h3>
                </div>
            </div>
        </g:if>

    </div>

</g:else>