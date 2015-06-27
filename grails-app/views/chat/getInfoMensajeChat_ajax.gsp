<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 25-Jun-15
  Time: 19:13
--%>

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
        ${params.id}
    </div>
</div>

<div class="row">
    <div class="col-md-12 text-center">
        <a href="#" onclick="test()" class="btn btn-success" id="btnResolver">
            <i class="fa fa-check"></i> Marcar como resuelto
        </a>
    </div>
</div>
