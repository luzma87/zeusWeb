<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 18/12/14
  Time: 11:59 AM
--%>

<%@ page import="arazu.solicitudes.NotaPedido" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Pantalla de inicio</title>
        <style type="text/css">
        .inicio img {
            height : 190px;
        }

        i {
            margin-right : 5px;
        }
        </style>
        <link href="${g.resource(dir: 'css/custom/', file: 'dashboard.css')}" rel="stylesheet" type="text/css">
    </head>

    <body>
        <div class="row">
            <div class="card">
                <div class="titulo-card"><i class="fa fa-newspaper-o"></i> Notas de pedido</div>

                <div class="cardContent" title="${estadoPr.descripcion}">
                    <div class="circle-card ${pr.size()>0?'svt-bg-warning':'card-bg-green'}">${pr.size()}</div>
                    ${estadoPr.nombre}
                </div>
                <div class="cardContent" title="${estadoPa.descripcion}">
                    <div class="circle-card ${pr.size()>0?'svt-bg-warning':'card-bg-green'}">${pa.size()}</div>
                    ${estadoPa.nombre}
                </div>
            </div>
            <div class="card">
                <div class="titulo-card"><i class="fa fa-shopping-cart"></i> Ordenes de compra - Febrero</div>

                <div class="cardContent" title="${estadoAp.descripcion}">
                    <div class="circle-card card-bg-green">${aprobadas.size()}</div>
                    ${estadoAp.nombre}
                </div>
                <div class="cardContent" title="${estadoEj.descripcion}">
                    <div class="circle-card card-bg-green">${ejecutadas.size()}</div>
                    ${estadoEj.nombre}
                </div>
            </div>
            <div class="card">
                <div class="titulo-card"><i class="fa fa-tachometer"></i> Operaciones</div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">${proyectos.size()}</div>
                    Proyectos activos
                </div>
                <div class="cardContent">
                    <div class="circle-card ${proyectos.size()>bodegas.size()?'svt-bg-warning':'card-bg-green'}">${bodegas.size()}</div>
                    Bodegas activas
                </div>
            </div>

        </div>
        <div class="row">
        <div class="table-report">
            <div class="titulo-report"><i class="fa fa-sort-amount-asc"></i>Reporte de actividad</div>
            <div class="report-content">
                <table class="table table-striped table-hover table-bordered" style="border-top: none">
                    <thead>
                        <tr>
                            <th class="header-table-report" style="width: 70%;text-align: left">Proyecto</th>
                            <th class="header-table-report">Personal</th>
                            <th class="header-table-report">Pedidos</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${proyectos}" var="p">
                        <tr>
                            <td>${p.nombre}</td>
                            <td style="text-align: center">${arazu.proyectos.Funcion.findAllByProyecto(p).size()}</td>
                            <td style="text-align: center">${arazu.solicitudes.NotaPedido.findAllByProyecto(p).size()}</td>
                        </tr>
                    </g:each>

                    </tbody>
                </table>
            </div>
        </div>
            <div class="card">
                <div class="titulo-card"><i class="fa fa-warning"></i> Alertas</div>

                <div class="cardContent">
                    <div class="circle-card ${alertas.size()>0?'svt-bg-danger':'card-bg-green'}">${alertas.size()}</div>
                    Pendientes
                </div>
            </div>
        </div>



    </body>
</html>