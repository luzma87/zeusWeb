<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="P&S Sistema contable"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <imp:favicon/>
    <imp:importJs/>
    <imp:plugins/>
    <imp:customJs/>
    <imp:spinners/>
    <imp:importCss/>
    <g:layoutHead/>
</head>
<body>
<div class="menu">
    <ul class="nav menu-vertical">
        <li class="info-user toggle-menu">
            <div class="circulo-logo" style="margin-left: 20px;margin-top: 22px">
                <img src="${g.resource(dir: 'images',file: 'logo_policia.png')}" height="40px" >
            </div>
            <div class="row fila">
                <div class="col-md-11 col-md-offset-1" >
                    <span style="font-weight: bold;color: #fff">Nombre apellido</span>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-11 col-md-offset-1">
                    <span>Perfil</span>
                </div>
            </div>
        </li>
        <li class="menu-item">
            <a href="${g.createLink(controller: 'inicio',action: 'index')}" title="Inicio">
                <i class="fa-menu fa fa-home"></i>
                <span class="toggle-menu"> Inicio </span>
            </a>
        </li>
        <li class="menu-item active dropdown">
            <a href="#" class="dropdown-toggle active " title="Chat">
                <i class="fa-menu fa fa-wechat"></i>
                <span class="toggle-menu">Chat</span>
                <span class="caret toggle-menu"></span></a>
            <ul class="submenu " style="margin-top: 0px">
                <li><a href="${g.createLink(controller: 'chat',action: 'index')}" class="active">Público</a></li>
                <li><a href="${g.createLink(controller: 'chatPolicia',action: 'index')}">Policías</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="${g.createLink(controller: 'busquedas',action: 'index')}" title="Busquedas">
                <i class="fa-menu fa fa-search"></i>
                <span class="toggle-menu"> Busquedas</span>
            </a>
        </li>
        <li class="menu-item">
            <a href="${g.createLink(controller: 'mapa',action:  'index')}" title="Incidencias">
                <i class="fa-menu fa fa-map-marker"></i>
                <span class="toggle-menu"> Incidencias</span>
            </a>
        </li>

        <li class="menu-item">
            <a href="${g.createLink(controller: 'persona',action: 'list')}" title="Usuarios">
                <i class="fa-menu fa fa-users"></i>
                <span class="toggle-menu"> Usuarios</span>
            </a>
        </li>
    </ul>
</div>
<div class="contenido">
    <g:layoutBody/>
</div>
<script type="text/javascript">
    var estadoMenu = 1
    $("#control-menu").click(function(){
        $(".toggle-menu").toggle()
        if(estadoMenu==1){
            $(".submenu").hide()
            $(".menu").animate({
                width:55
            })
            $(".contenido").animate({
                marginLeft:"55"
            })
            estadoMenu=0

        }else{
            $(".menu").animate({
                width:190
            })
            $(".contenido").animate({
                marginLeft:"190"
            })
            estadoMenu=1
        }
        return false
    })
    $(".dropdown-toggle").click(function(){
        if(estadoMenu==1)
            $(this).parent().find(".submenu").toggle()
        else {
            $("#control-menu").click()
            $(this).parent().find(".submenu").toggle()
        }
        return false
    })
</script>
</body>
</html>
