<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 27-Jun-15
  Time: 17:53
--%>
<div style="max-height: 300px; overflow: auto">
    <table class="table table-condensed table-bordered table-striped table-hover verde">
        <thead>
            <tr>
                <g:sortableColumn property="resumen" title="Resumen" style="width:200px;"/>
                <g:sortableColumn property="contenido" title="Contenido"/>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <g:if test="${mensajeComunidadInstanceList.size() > 0}">
                <g:each in="${mensajeComunidadInstanceList + mensajeComunidadInstanceList + mensajeComunidadInstanceList + mensajeComunidadInstanceList}" status="i" var="mensajeComunidadInstance">
                    <tr class="text-default">
                        <td>${mensajeComunidadInstance.resumen}</td>
                        <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${mensajeComunidadInstance}" field="contenido"/></elm:textoBusqueda></td>
                        <td>
                            <a class="btn btn-xs btn-success btn-select" data-contenido="${mensajeComunidadInstance.contenido}">
                                <i class="fa fa-check"></i>
                            </a>
                        </td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <tr class="danger">
                    <td class="text-center" colspan="2">
                        <g:if test="${params.search && params.search != ''}">
                            No se encontraron resultados para su búsqueda
                        </g:if>
                        <g:else>
                            No se encontraron registros que mostrar
                        </g:else>
                    </td>
                </tr>
            </g:else>
        </tbody>
    </table>
</div>
<script type="text/javascript">
    $(function () {
        $(".btn-select").click(function () {
            var texto = "msc:" + $(this).data("contenido");
            enviarMensaje(texto);
            $("#dlgMensajesComunidad").modal("hide");
        });
    });
</script>