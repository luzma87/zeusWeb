<table class="table table-bordered table-condensed table-hover table-striped">
    <thead>
    <tr>
        <th>Fecha</th>
        <th>De</th>
        <th>Chat</th>
        <th>Mensaje</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${lista}" var="m">
        <tr>
            <td style="width: 15%">${new Date(m.id).format("dd-MM-yyyy HH:mm:ss")}</td>
            <td>${m.fromJID.split("@")[0]}</td>
            <td>${m.toJID.split("@")[0]}</td>
            <g:if test="${m.body.size()>4}">
                <td>${m.body.substring(4)}</td>
            </g:if>
            <g:else>
                <td>${m.body}</td>
            </g:else>

        </tr>
    </g:each>
    </tbody>
</table>