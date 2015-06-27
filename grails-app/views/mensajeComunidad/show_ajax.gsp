<%@ page import="mensajes.MensajeComunidad" %>

<g:if test="${!mensajeComunidadInstance}">
    <elm:notFound elem="MensajeComunidad" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${mensajeComunidadInstance?.resumen}">
            <div class="row">
                <div class="col-sm-3 show-label text-default">
                    Resumen
                </div>

                <div class="col-sm-4 text-default">
                    <g:fieldValue bean="${mensajeComunidadInstance}" field="resumen"/>
                </div>

            </div>
        </g:if>

        <g:if test="${mensajeComunidadInstance?.contenido}">
            <div class="row">
                <div class="col-sm-3 show-label text-default">
                    Contenido
                </div>

                <div class="col-sm-4 text-default">
                    <g:fieldValue bean="${mensajeComunidadInstance}" field="contenido"/>
                </div>

            </div>
        </g:if>

    </div>
</g:else>