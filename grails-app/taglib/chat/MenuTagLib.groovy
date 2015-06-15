package chat

class MenuTagLib {
    static namespace = 'mn'

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
                        controller: "pruebas",
                        action    : "index",
                        label     : "Chat",
                        icon      : "fa-whatsapp"
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
}
