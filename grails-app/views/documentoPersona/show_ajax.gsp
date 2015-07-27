
<%@ page import="documentos.DocumentoPersona" %>

<g:if test="${!documentoPersonaInstance}">
    <elm:notFound elem="DocumentoPersona" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${documentoPersonaInstance?.documento}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Documento
                </div>
                
                <div class="col-sm-4">
                    ${documentoPersonaInstance?.documento?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${documentoPersonaInstance?.fechaPresentacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fecha Presentacion
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${documentoPersonaInstance?.fechaPresentacion}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${documentoPersonaInstance?.persona}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Persona
                </div>
                
                <div class="col-sm-4">
                    ${documentoPersonaInstance?.persona?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>