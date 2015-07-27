<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 25-Jun-15
  Time: 19:13
--%>

<imp:js src="${g.resource(dir: 'js', file: 'ui.js')}"/>

<div class="row">
    <div class="col-md-3">
        <label>Tipo</label>
    </div>

    <div class="col-md-9">
        <g:set var="tipo" value="${params.msg[0..2]}"/>
        ${tipos[tipo].title}
    </div>
</div>

<div class="row">
    <div class="col-md-3">
        <label>Estado</label>
    </div>

    <div class="col-md-9" id="${inc}_estado">
        ${inc.estado == 'P' ? 'Pendiente' : 'Resuelto'}
    </div>
</div>

<div class="row">
    <div class="col-md-3">
        <label>Fecha</label>
    </div>

    <div class="col-md-9">
        ${params.fecha}
    </div>
</div>

<div class="row">
    <div class="col-md-3">
        <label>De</label>
    </div>

    <div class="col-md-9">
        ${params.from}
    </div>
</div>

<div class="row">
    <div class="col-md-12 text-center">
        <g:if test="${inc.estado != 'R'}">
            <a href="#" onclick="cambiarEstado(${inc.id}, '${inc.de}', '${inc.tipo}')" class="btn btn-success" id="${inc.id}_btnResolver" iden="${inc.id}" title="Unidades en camino">
                <i class="fa fa-motorcycle"></i>
            </a>
        </g:if>
        <g:else>
            <a href="#" onclick="quitar(${inc.id}, '${inc.de}', '${inc.tipo}')" class="btn btn-danger" id="${inc.id}_btnQuitar" iden="${inc.id}" title="Quitar del mapa">
                <i class="fa fa-times"></i>
            </a>
        </g:else>
    </div>
</div>
