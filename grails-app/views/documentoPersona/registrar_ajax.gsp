<%@ page import="documentos.Documento" %>
<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 27/07/15
  Time: 08:57 AM
--%>

<p>
    Registre los documentos presentados por <span class="text-verde">${persona.nombre}</span>
</p>

<div class="well">
    <ul class="fa-ul">
        <g:set var="docs" value="${persona.documentos.documento.id}"/>
        <g:each in="${Documento.list([sort: 'nombre'])}" var="doc">
            <g:set var="tiene" value="${false}"/>
            <g:if test="${docs.contains(doc.id)}">
                <g:set var="tiene" value="${true}"/>
            </g:if>
            <li class="liDoc ${tiene ? 'active text-verde' : ''}" data-id="${doc.id}">
                <i class="fa-li fa ${tiene ? 'fa-check-square-o' : 'fa-square-o'}"></i>
                ${doc}
            </li>
        </g:each>
    </ul>
</div>

<script type="text/javascript">
    function activar($item) {
        $item.addClass("active text-verde");
        $item.find("i").removeClass("fa-square-o").addClass("fa-check-square-o");
    }
    function desactivar($item) {
        $item.removeClass("active text-verde");
        $item.find("i").removeClass("fa-check-square-o").addClass("fa-square-o");
    }
    $(function () {
        $(".liDoc").click(function () {
            var $item = $(this);
            if ($item.hasClass("active")) {
                //desactivar
                desactivar($item);
            } else {
                //activar
                activar($item);
            }
            return false;
        });
    });
</script>