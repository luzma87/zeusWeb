<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <script src="http://maps.googleapis.com/maps/api/js"></script>
    <script src="${g.resource(dir: 'js',file: 'markerwithlabel.js')}"></script>
    <script>
        var map
        function toggleBounce(marker) {

            if (marker.getAnimation() != null) {
                marker.setAnimation(null);
            } else {
                marker.setAnimation(google.maps.Animation.BOUNCE);
            }
        }
        function stopBounce(pos) {

            if (marker.getAnimation() != null) {
                marker.setAnimation(null);
            } else {
                marker.setAnimation(google.maps.Animation.BOUNCE);
            }
        }
        function initialize() {
            var mapProp = {
                center:new google.maps.LatLng(-0.16481615,-78.47895741),
                zoom:15,
                mapTypeId:google.maps.MapTypeId.ROADMAP
            };
            map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

        }
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
    <title>Zeus - chat</title>
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
        border: 1px solid #36579F;

    }
    .mio{
        padding: 5px;
        display: inline-block;
        border-radius: 5px;
        background: #2196f3;
        margin-bottom: 5px;
        color: #d2d2d2;
        text-align: left;
        cursor: pointer;
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
        cursor: pointer;
        position: relative;
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
    .ventana{
        width: 150px;
        height: 210px;
    }
    .fila-ventana{
        width: 100%;
        height: 25px;
        padding: 3px;
    }
    body{
        margin-bottom: 0px !important;

    }
    .labels {
        color: #000000;
        background-color: white;
        font-family: "Lucida Grande", "Arial", sans-serif;
        font-size: 10px;
        font-weight: bold;
        text-align: center;
        width: 60px;
        border: 1px solid #36579F;
        border-radius: 3px;
        white-space: nowrap;
    }
    .label-emergencia {
        color: #ffffff;
        background-color: #ff374d;
        font-family: "Lucida Grande", "Arial", sans-serif;
        font-size: 10px;
        font-weight: bolder;
        text-align: center;
        padding: 5px;
        border: 1px solid #fcf2ff;
        border-radius: 3px;
        white-space: nowrap;
    }
    </style>
</head>
<body>
<div class="row">
    <div class="col-botones">
        <a href="#" class="btn btn-success btn-barra" title="" id="broadcast">
            <i class="fa fa-rss"></i>
        </a>
        <a href="#" class="btn btn-warning btn-barra btn-utils" title="Avanzan unidades" id="unidades">
            <i class="fa fa-motorcycle"></i>
        </a>
        <a href="#" class="btn btn-primary btn-barra btn-utils" title="911 en camino" id="911">
            <i class="fa fa-cab"></i>
        </a>
        <a href="#" class="btn btn-danger btn-barra btn-utils" title="Ambulancia en camino" id="ambulancia">
            <i class="fa fa-ambulance"></i>
        </a>
        <a href="#" class="btn btn-info btn-barra btn-utils" title="Sospechoso detenido" id="sospechoso">
            <i class="fa fa-child"></i>
        </a>
        <a href="#" class="btn btn-default btn-barra" title="Enviar foto" id="foto">
            <i class="fa fa-photo"></i>
        </a>

    </div>
    <div class="col-md-6 divIzq" style="position:relative;">
        <div class=" " id="mensajes" ></div>
        <div class="ingreso">
            <textarea class="txt-ingreso" id="mensaje-txt"></textarea>
            <a href="#" class="btn btn-info" id="enviar" style="width: 19%;height: 100%;line-height: 90px;display: inline-block;margin-top: -93px">
                <i class="fa fa-share-square-o" style="margin-right: 6px"></i> Enviar
            </a>
        </div>
    </div>

    <div class="col-md-5 divDer" id="googleMap">

    </div>
</div>
<div class="ventana" style="display: none"></div>
<script type="text/javascript">
    var actual =0
    var user ="${user}"
    var markers = []
    function infoMensaje(){
        openLoader()

        $.ajax({
            type:"POST",
            url: "${g.createLink(controller: 'pruebas',action: 'getInfoMensaje_ajax')}",
            data:"user="+$(this).attr("user")+"&mensaje="+$(this).attr("mensaje"),
            success : function(msg){
                closeLoader()

            }
        });
    }

    function showPin(latitud,longitud,nombre){
        var image = '${g.resource(dir: "images",file: "ping1.png")}';
        var myLatlng = new google.maps.LatLng(latitud,longitud);
        var marker =  new MarkerWithLabel({
            position: myLatlng,
            map: map,
            title: nombre,
            icon: image,
            labelContent: nombre,
            labelAnchor: new google.maps.Point(30, 55),
            labelClass: "labels", // the CSS class for the label
            labelStyle: {opacity: 0.90}
        });
        markers.push(marker)
    }
    function showPinUbicacion(latitud,longitud,nombre,hora){

        var image = '${g.resource(dir: "images",file: "ping2.png")}';
        var myLatlng = new google.maps.LatLng(latitud,longitud);
        var marker = new  MarkerWithLabel({
            position: myLatlng,
            map: map,
            title: "Asalto reportado: "+hora,
            icon: image,
            labelContent: nombre,
            labelAnchor: new google.maps.Point(30, 55),
            labelClass: "label-emergencia", // the CSS class for the label
            labelStyle: {opacity: 0.90}
        });
        map.setCenter(marker.getPosition());
        map.setZoom(17);
        google.maps.event.addListener(marker, 'idle', toggleBounce(marker));
        google.maps.event.addListener(marker, 'click',function(){
            if (marker.getAnimation() != null) {
                marker.setAnimation(null);
            } else {
                marker.setAnimation(google.maps.Animation.BOUNCE);
            }
        });
        markers.push(marker)
    }
    function appendMensaje(val){
        var div
        var container
        if(val.mensaje.length>0){

            if(val.mensaje.substring(0,3)=="loc"){
                var loc =val.mensaje.substring(4,val.mensaje.length)
                loc=loc.split(",")
                showPinUbicacion(loc[0]*1,loc[1]*1,val.de,val.hora)

            }
        }
        if(val.de==user) {
            div = $("<div class='mio' user='"+val.de+"'  mensaje='"+val.mensaje+"'><span class='usuario'>" + val.de + " (" + val.hora + "): </span>" + val.mensaje + "</div>")
            container=$("<div class='fila txt-der'></div>")
            container.append(div)
            $("#mensajes").append(container);
        } else {
            div = $("<div class='mensaje' user='"+val.de+"'  mensaje='"+val.mensaje+"'><span class='usuario'>" + val.de + " (" + val.hora + "): </span>" + val.mensaje + "</div>")
            container=$("<div class='fila'></div>")
            container.append(div)
            $("#mensajes").append(container);
        }
        //div.click(infoMensaje)
        div.qtip({
            content: {
                title:"Información del usuario",
                text: function(event, api) {
                    $.ajax({
                        url: "${g.createLink(controller: 'pruebas',action: 'getInfoMensaje_ajax')}",
                        data:"user="+$(this).attr("user")+"&mensaje="+$(this).attr("mensaje")
                    })
                            .then(function(content) {
                                // Set the tooltip content upon successful retrieval
                                api.set('content.text', content);
                            }, function(xhr, status, error) {
                                // Upon failure... set the tooltip content to error
                                api.set('content.text', status + ': ' + error);
                            });

                    return 'Loading...'; // Set some initial text
                }
            },
            position: {
                viewport: $(window)
            },
            style: 'qtip-dark',
            show: {
                event: 'click'
            },
            hide: 'unfocus'
        });
    }
    var first = true
    setInterval(function(){
        var scroll = false
        var s = $("#mensajes").scrollTop()
        $("#mensajes").scrollTop(s+1)
        var s2 = $("#mensajes").scrollTop()
        if(s==s2){
            scroll=true
        }else{
            $("#mensajes").scrollTop(s)
        }
        if(first)
            scroll=true
        first=false
       // console.log($("#mensajes").scrollTop(),$("#mensajes")[0].scrollHeight,scroll)
        $.ajax({
            type:"POST",
            url: "${g.createLink(controller: 'pruebas',action: 'getMessages_ajax')}",
            data:"actual="+actual,
            dataType:"json",
            success : function(msg){
                var data =msg
                actual=actual+data.length
                if(data.length>0){
                    document.title=""+data.length+" mensajes nuevos"
                }
                $.each(data, function(i, val) {
                    appendMensaje(val)

                });
                if(scroll) {
                    $("#mensajes").scrollTop($("#mensajes")[0].scrollHeight);
                    document.title="Zeus - chat"
                }
            }
        });
    }, 3000);

    $("#enviar").click(function(){
        var texto = $("#mensaje-txt").val()
        if($.trim(texto)!=""){
            $.ajax({
                type:"POST",
                url: "${g.createLink(controller: 'pruebas',action: 'enviarMensaje_ajax')}",
                data:"mensaje="+$("#mensaje-txt").val(),
                success : function(msg){
                    $("#mensaje-txt").val("")
                    $("#mensaje-txt").html("")
                }
            });
            return false
        }

    })
    $("#mensaje-txt").keydown(function (ev) {
        if (ev.keyCode == 13) {
            var texto = $("#mensaje-txt").val()
            if($.trim(texto)!=""){
                $.ajax({
                    type:"POST",
                    url: "${g.createLink(controller: 'pruebas',action: 'enviarMensaje_ajax')}",
                    data:"mensaje="+$("#mensaje-txt").val(),
                    success : function(msg){
                        $("#mensaje-txt").val("")
                        $("#mensaje-txt").html("")
                    }
                });
                return false
            }
        }
        return true;
    });
    $(".btn-utils").click(function(){
        $.ajax({
            type:"POST",
            url: "${g.createLink(controller: 'pruebas',action: 'enviarMensaje_ajax')}",
            data:"mensaje="+$(this).attr("title"),
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