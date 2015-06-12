
<%@ page import="seguridad.Persona" %>

<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${personaInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.login}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Login
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="login"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.cedula}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cedula
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="cedula"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.email}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Email
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="email"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.direccion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Direccion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="direccion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.longitud}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Longitud
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="longitud"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.latitud}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Latitud
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="latitud"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.telefono}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Telefono
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="telefono"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.celular}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Celular
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="celular"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.creacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Creacion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="creacion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.modificacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Modificacion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="modificacion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${personaInstance?.tipo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${personaInstance}" field="tipo"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>