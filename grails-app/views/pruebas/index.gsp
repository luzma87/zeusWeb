<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Demo</title>
    <style type="text/css">
    .divIzq{
        height: 520px;
        border-radius: 5px;
        margin-right: 0px;
    }
    #mensajes{
        height: 416px;
        overflow: auto;
        padding: 10px;
        width: 100%;
        background: #ddd;
        margin-top: 0px;
        border-radius: 5px;
        border: 1px solid #36579F;
    }
    .ingreso{
        width: 100%;
        height: 100px;
        margin-top: 5px;
    }
    .divDer{
        height: 520px;
        overflow: auto;
        border-bottom-right-radius: 5px;
        border-top-right-radius: 5px;
        padding: 10px;

    }
    .mio{
        padding: 5px;
        display: inline-block;
        border-radius: 5px;
        background: #2196f3;
        margin-bottom: 5px;
        color: #d2d2d2;
        text-align: left;

    }
    .fila{
        width: 100%;
    }
    .mensaje{
        padding: 5px;
        display: inline-block;
        border-radius: 5px;
        background: #ffd781;
        margin-bottom: 5px;
        color: #000000;

    }
    .usuario{
        font-weight: bold;
    }
    .txt-ingreso{
        width: 80%;
        display: inline-block;
        height: 100%;
        resize: none;
        border-radius: 5px;
        padding: 10px;
    }
    .txt-der{
        text-align: right;
    }
    .col-botones{
        height: 520px;
        width: 45px;
        display: inline-table;
        float: left;
        margin-left: -12px;

    }
      .btn-barra{
          margin: 2px;
          width: 40px;
          height: 40px;
          line-height: 30px;

      }
    </style>
</head>
<body>
<div class="row">
    <div class="col-md-6 divIzq" style="position:relative;">
        <div class=" " id="mensajes" ></div>
        <div class="ingreso">
            <textarea class="txt-ingreso" id="mensaje-txt"></textarea>
            <a href="#" class="btn btn-info" id="enviar" style="width: 19%;height: 100%;line-height: 90px;display: inline-block;margin-top: -93px">
                <i class="fa fa-share-square-o" style="margin-right: 6px"></i> Enviar
            </a>
        </div>
    </div>
    <div class="col-botones">
        <a href="#" class="btn btn-success btn-barra" title="" id="broadcast">
            <i class="fa fa-rss"></i>
        </a>
        <a href="#" class="btn btn-warning btn-barra" title="Avanzan unidades" id="unidades">
            <i class="fa fa-motorcycle"></i>
        </a>
        <a href="#" class="btn btn-primary btn-barra" title="911 en camino" id="911">
            <i class="fa fa-cab"></i>
        </a>
        <a href="#" class="btn btn-danger btn-barra" title="Ambulancia en camino" id="ambulancia">
            <i class="fa fa-ambulance"></i>
        </a>
        <a href="#" class="btn btn-info btn-barra" title="Sospechoso detenido" id="sospechoso">
            <i class="fa fa-child"></i>
        </a>
        <a href="#" class="btn btn-default btn-barra" title="Enviar foto" id="foto">
            <i class="fa fa-photo"></i>
        </a>

    </div>
    <div class="col-md-5 divDer"></div>
</div>
<script type="text/javascript">
    var actual =0
    var user ="${user}"
    function appendMensaje(val){
        if(val.de==user)
            $("#mensajes").append("<div class='fila txt-der'><div class='mio'><span class='usuario'>"+val.de+" ("+val.hora+"): </span>"+val.mensaje+"</div></div>");
        else
            $("#mensajes").append("<div class='fila'><div class='mensaje'><span class='usuario'>"+val.de+" ("+val.hora+"): </span>"+val.mensaje+"</div></div>");
    }
    setInterval(function(){
        $.ajax({
            type:"POST",
            url: "${g.createLink(controller: 'pruebas',action: 'getMessages')}",
            data:"actual="+actual,
            dataType:"json",
            success : function(msg){
                var data =msg
                actual=actual+data.length
                $.each(data, function(i, val) {
                    appendMensaje(val)

                });
                $("#mensajes").scrollTop($("#mensajes")[0].scrollHeight);
            }
        });
    }, 3000);

    $("#enviar").click(function(){
        $.ajax({
            type:"POST",
            url: "${g.createLink(controller: 'pruebas',action: 'enviarMensaje')}",
            data:"mensaje="+$("#mensaje-txt").val(),
            success : function(msg){
                $("#mensaje-txt").val("")
                $("#mensaje-txt").html("")
            }
        });
        return false
    })

</script>
</body>
</html>