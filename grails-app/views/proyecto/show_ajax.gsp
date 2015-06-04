
<%@ page import="arazu.proyectos.Proyecto" %>

<g:if test="${!proyectoInstance}">
    <elm:notFound elem="Proyecto" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${proyectoInstance?.fechaFin}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fecha Fin
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${proyectoInstance?.fechaFin}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${proyectoInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${proyectoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${proyectoInstance?.entidad}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Entidad
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${proyectoInstance}" field="entidad"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${proyectoInstance?.fechaInicio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fecha Inicio
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${proyectoInstance?.fechaInicio}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${proyectoInstance?.latitud}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Latitud
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${proyectoInstance}" field="latitud"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${proyectoInstance?.longitud}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Longitud
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${proyectoInstance}" field="longitud"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${proyectoInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${proyectoInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${proyectoInstance?.zoom}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Zoom
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${proyectoInstance}" field="zoom"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>