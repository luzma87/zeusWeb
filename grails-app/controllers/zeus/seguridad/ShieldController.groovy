package arazu.seguridad

class ShieldController {

    def unauthorized_401 = {

    }

    def forbidden_403 = {
        def msn = "No tiene autorización para ingresar a esta página." +
                " Por favor utilice el menú y los botones disponibles para navegar en el sistema.   "
        if (flash.message) {
            msn = flash.message
        }
        return [msn: msn]
    }

    def notFound_404 = {
        println ""
        def msn = "Esta tratando de ingresar a una accion no registrada en el sistema. Por favor use las opciones del menu para navegar por el sistema."
        return [msn: msn]
    }

    def internalServerError_500 = {
        def msn = "Ha ocurrido un error interno."
        try {
            println " \n<=== Error Aqui ===> " + request["javax.servlet.forward.request_uri"]
            println " \n<=== Exception ===> " + request["exception"].message?.encodeAsHTML()
            println " \n<=== Causa ===> " + request["exception"].cause?.message?.encodeAsHTML()

        } catch (e) {
            println "error en error " + e
        }
        return [msn: msn, error: true]
    }
}
