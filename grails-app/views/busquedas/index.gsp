<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Búsqueda</title>
        <meta name="layout" content="main"/>
    </head>

    <body>
        %{--<mn:barraTop titulo="Búsquedas"></mn:barraTop>--}%
        <div class="row fila">
            <div class="panel-completo" style="padding: 5px">
                <div class="row fila" style="margin-left: 0">
                    <div class="col-md-11 titulo-panel" style="position: relative">
                        Parámetros de búsqueda
                    </div>
                </div>

                <div class="row fila" style="margin-left: 0">
                    <div class="col-md-1" style="width: 60px">
                        <label>Desde</label>
                    </div>

                    <div class="col-md-2">
                        <elm:datepicker name="desde" class="form-control input-sm desde" showTime="true"></elm:datepicker>
                    </div>

                    <div class="col-md-1" style="width: 60px">
                        <label>Hasta</label>
                    </div>

                    <div class="col-md-2">
                        <elm:datepicker name="hasta" class="form-control  hasta" showTime="true"></elm:datepicker>
                    </div>

                    <div class="col-md-1" style="width: 50px">
                        <label>De</label>
                    </div>

                    <div class="col-md-2">
                        <g:select name="de" id="de" from="${seguridad.Persona.list()}" class="input-sm" optionKey="login"
                                  optionValue="login" data-live-search="true"
                                  data-width="100%" noSelection="['': 'Todos']"></g:select>
                    </div>

                    <div class="col-md-1" style="width: 60px">
                        <label>Chat</label>
                    </div>

                    <div class="col-md-2">
                        <g:select name="chat" id="para" from="${mensajes.Room.list()}" class="input-sm"
                                  optionKey="name" optionValue="name" data-live-search="true"
                                  data-width="100%" noSelection="['': 'Todos']"></g:select>
                    </div>

                    <div class="col-md-1">
                        <a hidden="#" class="btn btn-primary" id="buscar">
                            <i class="fa fa-search"></i> Buscar
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row fila">
            <div class="panel-completo" style="padding: 5px">
                <div class="row fila" style="margin-left: 0">
                    <div class="col-md-11 titulo-panel" style="position: relative">
                        Resultado
                    </div>
                </div>

                <div class="row fila" style="margin-left: 0">
                    <div class="col-md-12" id="detalle"></div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $("#buscar").click(function () {
                openLoader()
                $("#detalle").html("")
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'busquedas',action: 'buscar_ajax')}",
                    data    : {
                        desde : $("#desde_input").val(),
                        hasta : $("#hasta_input").val(),
                        de    : $("#de").val(),
                        para  : $("#para").val()
                    },
                    success : function (msg) {
                        closeLoader()
                        $("#detalle").html(msg)
                    }
                });
            })
        </script>
    </body>
</html>