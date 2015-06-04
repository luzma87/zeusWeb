<%--
  Created by IntelliJ IDEA.
  User: Luz
  Date: 3/5/2015
  Time: 10:07 PM
--%>

<style type="text/css">
.ic {
    border  : solid 1px #666;
    margin  : 1px;
    padding : 2px;
    cursor  : pointer;
    color   : #444;
}

.selected {
    background   : #077dbf;
    border-color : #043a59;
    color        : white;
}
</style>

<div style="max-height: 400px; overflow: auto; padding: 0 5px;">
    <ul class="list-inline">
        <li class="ic corner-all ${params.selected == '' ? 'selected' : ''}" data-str="">
            Sin ícono
        </li>
        <g:each in="${icons}" var="i">
            <li class="ic corner-all ${params.selected == i ? 'selected' : ''}" data-str="${i}">
                <i class=" fa-2x ${i}"></i>
            </li>
        </g:each>
    </ul>
</div>

<script type="text/javascript">
    $(function () {
        $(".ic").click(function () {
            $(".selected").removeClass("selected");
            $(this).toggleClass("selected");
        });
    });
</script>