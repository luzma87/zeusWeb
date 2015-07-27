<%@ page import="documentos.Documento" %>
<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 27/07/15
  Time: 08:57 AM
--%>

<ul class="fa-ul">
    <g:each in="${Documento.list([sort: 'nombre'])}" var="doc">
        <li class="liDoc">
            <i class="fa-li fa fa-square-o"></i>
            ${doc}
        </li>
    </g:each>
</ul>

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