package chat

import seguridad.Persona

class MenuTagLib {
    static namespace = 'mn'


    def barraTop = { attrs ->
        def titulo = attrs['titulo']
        def html = '<nav class="default navbar">\n' +
                '    <div class="row">\n' +
                '        <div class="col-md-1 col-xs-2 col-sm-1" style="width: 50px">\n' +
                '            <a href="#" class="btn btn-verde " id="control-menu">\n' +
                '                <i class="fa fa-bars"></i>\n' +
                '            </a>\n' +
                '        </div>\n' +

                '        <div class="col-md-9 titulo hidden-sm hidden-xs ">\n' + titulo +
                '        </div>\n' +
//                '        <div class="col-md-1 hidden-xs" style="width: 50px;margin-top: 10px">\n' +
//                '            <a href="#" class="item" title="Alertas" >\n' +
//                '                <i class="fa fa-bell"></i>\n' +
//                '            </a>\n' +
//                '        </div>\n' +
                '        <div class="col-md-1 col-xs-2 col-sm-2 " style="margin-top: 10px">\n' +
                '            <a href="' + createLink(controller: 'login', action: 'logout') + '" class="item" >\n' +
                '                <i class="fa fa-sign-out"></i> Salir\n' +
                '            </a>\n' +
                '        </div>\n' +
                '    </div>\n' +
                '</nav>'
        out << html
    }

    def stickyFooter = { attrs ->
        def html = ""
        html += "<footer class='footer ${attrs['class']}'>"
        html += "<div class='container text-center'>"
        html += "Zeus - 2015 Todos los derechos reservados"
        html += "</div>"
        html += "</footer>"
        out << html
    }

    def bannerTop = { attrs ->

        def large = attrs.large ? "banner-top-lg" : ""

        def html = ""
        html += "<div class='banner-top ${large}'>"
        html += "<div class='banner-esquina'>"
        html += "</div>"
        html += "<div class='banner-title'>Zeus</div>"
        html += "<div class='banner-logo'>"
        html += "</div>"
        html += "<div class='banner-esquina der'>"
        html += "</div>"

        html += "</div>"

        out << html
    }

    def menu = { attrs ->
        def items = [:]
//        println "menu " + attrs
        def strItems = ""
        if (!attrs.title) {
            attrs.title = "Zeus"
        }
        items = [
                chat    : [
                        controller: "chat",
                        action    : "index",
                        label     : "Chat",
                        icon      : "fa-whatsapp"
                ],
                mapa    : [
                        controller: "mapa",
                        action    : "index",
                        label     : "Mapa de incidentes",
                        icon      : "fa-street-view"
                ],
                personas: [
                        controller: "persona",
                        action    : "list",
                        label     : "Personas",
                        icon      : "fa-users"
                ]
        ]

        items.each { k, item ->
            strItems += renderItem(item)
        }

        def alertas = "("
        def count = 0

        alertas += count
        alertas += ")"

        def html = "<nav class=\"navbar navbar-default navbar-fixed-top\" role=\"navigation\">"

        html += "<div class=\"container-fluid\">"

        // Brand and toggle get grouped for better mobile display
        html += '<div class="navbar-header">'
        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">'
        html += '<span class="sr-only">Toggle navigation</span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</button>'
        html += '<a class="navbar-brand navbar-logo" href="#">'
        html += '<img src="' + resource(dir: 'images', file: 'logo.jpg') + '" />'
        html += '</a>'
        html += '</div>'

        // Collect the nav links, forms, and other content for toggling
        html += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'
        html += '<ul class="nav navbar-nav">'
        html += strItems
        html += '</ul>'

        html += '<ul class="nav navbar-nav navbar-right">'
        html += '<li><a href="' + g.createLink(controller: 'alerta', action: 'list') + '" ' + ((count > 0) ? ' style="color:#ab623a" class="annoying"' : "") + '><i class="fa fa-exclamation-triangle"></i> Alertas ' + alertas + '</a></li>'
        html += '<li class="dropdown">'
        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">Admin <b class="caret"></b></a>'
        html += '<ul class="dropdown-menu">'
        // println "tipo "+session.tipo

        html += '<li class="divider"></li>'
        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-power-off"></i> Salir</a></li>'
        html += '</ul>'
        html += '</li>'
        html += '</ul>'

        html += '</div><!-- /.navbar-collapse -->'

        html += "</div>"

        html += "</nav>"

        out << html
    }

    def renderItem(item) {
        def str = "", clase = ""
        if (session.cn == item.controller && session.an == item.action) {
            clase = "active"
        }
        if (item.items) {
            clase += " dropdown"
        }
        str += "<li class='" + clase + "'>"
        if (item.items) {
            str += "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>"
            if (item.icon) {
                str += "<i class='fa ${item.icon}'></i>"
                str += " "
            }
            str += item.label
            str += "<b class=\"caret\"></b></a>"
            str += '<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">'
            item.items.each { t, i ->
                str += renderItem(i)
            }
            str += "</ul>"
        } else {
            str += "<a href='" + createLink(controller: item.controller, action: item.action, params: item.params) + "'>"
            if (item.icon) {
                str += "<i class='fa ${item.icon}'></i>"
                str += " "
            }
            str += item.label
            str += "</a>"
        }
        str += "</li>"

        return str
    }

    def verticalMenu = { attrs ->

        def usu = Persona.get(session.usuario.id)
        def tipo = usu.tipo
        def perfil = ""

        if (!tipo) {
            tipo = "C"
        }

        def items = null

        if (tipo == "C") {
            perfil = "Ciudadano"
            items = [
                    chat     : [
                            controller: "chatPersona",
                            action    : "index",
                            label     : "Chat",
                            icon      : "fa-wechat"
                    ],
                    servicios: [
                            label: "Servicios",
                            icon : "fa-cubes",
                            items: [
                                    encargar: [
                                            controller: "servicios",
                                            action    : "form",
                                            params    : [servicio: "encargar"],
                                            label     : "Encargar casa",
                                            icon      : "fa-home"
                                    ],
                                    movil   : [
                                            controller: "servicios",
                                            action    : "form",
                                            params    : [servicio: "movil"],
                                            label     : "Servicio móvil",
                                            icon      : "fa-mobile"
                                    ],
                                    contacto: [
                                            controller: "servicios",
                                            action    : "form",
                                            params    : [servicio: "contacto"],
                                            label     : "Contáctenos",
                                            icon      : "fa-comment"
                                    ]
                            ]
                    ],
                    pass     : [
                            controller: "persona",
                            action    : "admin",
                            label     : "Mi cuenta",
                            icon      : "fa-user"
                    ],
                    logout   : [
                            controller: "login",
                            action    : "logout",
                            label     : "Salir",
                            icon      : "fa-sign-out"
                    ]
            ]
        } else if (tipo == "P") {
            perfil = "Policía"
            items = [
                    inicio     : [
                            controller: "inicio",
                            action    : "index",
                            label     : "Inicio",
                            icon      : "fa-home"
                    ],
                    chat       : [
                            label: "Chat",
                            icon : "fa-wechat",
                            items: [
                                    publico: [
                                            controller: "chat",
                                            action    : "index",
                                            label     : "Comunitario",
                                            icon      : "fa-comments"
                                    ],
                                    policia: [
                                            controller: "chatPolicia",
                                            action    : "index",
                                            label     : "Policías",
                                            icon      : "fa-comment"
                                    ]
                            ]
                    ],
                    busquedas  : [
                            controller: "busquedas",
                            action    : "index",
                            label     : "Búsquedas",
                            icon      : "fa-search"
                    ],
                    incidentes : [
                            controller: "mapa",
                            action    : "index",
                            label     : "Incidentes",
                            icon      : "fa-map-marker"
                    ],
                    personas   : [
                            controller: "persona",
                            action    : "list",
                            label     : "Usuarios",
                            icon      : "fa-users"
                    ],
                    mensajesCom: [
                            controller: "mensajeComunidad",
                            action    : "list",
                            label     : "Mens. a la comunidad",
                            icon      : "fa-rss"
                    ],
                    logout     : [
                            controller: "login",
                            action    : "logout",
                            label     : "Salir",
                            icon      : "fa-sign-out"
                    ]
            ]
        }

        def strItems = ""
        items.each { k, item ->
            strItems += renderVerticalMenuItem(item)
        }

        def img = resource(dir: 'images', file: 'logo_policia.png')

        def html = "<div class='menu'>"
        html += "<ul class=\"nav menu-vertical\">"
        /* ****************** user info ********************/
        html += '<li class="info-user toggle-menu">'
        html += '<div class="circulo-logo" style="margin-left: 20px;margin-top: 22px">'
        html += '<img src="' + img + '" height="40px">'
        html += '</div>'
        html += '<div class="row fila">'
        html += '<div class="col-md-11 col-md-offset-1">'
        html += '<span style="font-weight: bold;color: #fff">' + usu.nombre + '</span>'
        html += '</div>'
        html += '</div>'
        html += '<div class="row fila">'
        html += '<div class="col-md-11 col-md-offset-1">'
        html += '<span>' + perfil + '</span>'
        html += '</div>'
        html += '</div>'
        html += '</li>'
        /* ****************** fin user info ********************/

        html += strItems

        html += "</ul>"
        html += "</div>" //.menu
        out << html
    }

    def renderVerticalMenuItem(item) {
        def html = ""

        def active = "non-active"
//        println session.cn
//        println session.an
        if (session.cn == item.controller && session.an == item.action) {
            active = "active"
        }

        if (item.items && item.items.size() > 0) {

            def submenuStr = ""
            item.items.each { itm ->
                def submenuActive = "non-active"
                def it = itm.value
                if (session.cn == it.controller && session.an == it.action) {
                    active = "active"
                    submenuActive = "active"
                }
                def url = createLink(controller: it.controller, action: it.action, params: it.params)
                submenuStr += '<li class="' + submenuActive + '">'
                submenuStr += '<a href="' + url + '">'
                if (it.icon) {
                    submenuStr += '<i class="fa-menu fa ' + it.icon + '"></i>'
                }
                submenuStr += it.label
                submenuStr += "</a>"
                submenuStr += '</li>'
            }

            html += '<li class="menu-item ' + active + ' dropdown">'
            html += '<a href="#" class="dropdown-toggle ' + active + ' " title="' + item.label + '">'
            if (item.icon) {
                html += '<i class="fa-menu fa ' + item.icon + '"></i>'
            }
            html += '<span class="toggle-menu">' + item.label + '</span>'
            html += '<span class="caret toggle-menu"></span></a>'
            html += '<ul class="submenu ' + active + '" style="margin-top: 0">'
            html += submenuStr
            html += '</ul>'
            html += '</li>'
        } else {
            def url = createLink(controller: item.controller, action: item.action, params: item.params)
            html += '<li class="menu-item ' + active + '">'
            html += '<a href="' + url + '" title="' + item.label + '">'
            if (item.icon) {
                html += '<i class="fa-menu fa ' + item.icon + '"></i>'
            }
            html += '<span class="toggle-menu">' + item.label + '</span>'
            html += '</a>'
            html += '</li>'
        }

        return html
    }

}
