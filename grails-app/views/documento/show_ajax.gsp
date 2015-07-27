
<%@ page import="documentos.Documento" %>

<g:if test="${!documentoInstance}">
    <elm:notFound elem="Documento" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${documentoInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${documentoInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${documentoInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${documentoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>