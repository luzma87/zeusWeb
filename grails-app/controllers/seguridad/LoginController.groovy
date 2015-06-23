package seguridad

class LoginController {

    /**
     * Acci�n que valida que la sesi�n est� activa
     */
    def validarSesion() {
        println "sesion creada el:" + new Date(session.getCreationTime()) + " hora actual: " + new Date()
        println "�ltimo acceso:" + new Date(session.getLastAccessedTime()) + " hora actual: " + new Date()

        println session.usuario
        if (session.usuario) {
            render "OK"
        } else {
            flash.message = "Su sesi�n ha caducado, por favor ingrese nuevamente."
            render "NO"
        }
    }

    /**
     * Acci�n que muestra la pantalla de login
     */
    def login() {
        def usu = session.usuario
        def cn = "sistema"
        def an = "index"
        if (usu) {
            if (session.cn && session.an) {
                cn = session.cn
                an = session.an
            }
            redirect(controller: cn, action: an)
        }
    }

    /**
     * Acci�n que valida las credenciales de login. Si el usuario tiene un solo perfil, inicia directamente la sesi�n, sino muestra la pantalla de selecci�n de perfil
     */
    def validar() {
        if (!params.user || !params.pass) {
            redirect(controller: "login", action: "login")
            return
        }
        def user = Persona.withCriteria {
            ilike("login", params.user)
        }
        if (user.size() == 0) {
            flash.message = "No se ha encontrado el usuario"
            flash.tipo = "error"
            redirect(controller: 'login', action: "login")
            return
        } else if (user.size() > 1) {
            flash.message = "Ha ocurrido un error grave"
            flash.tipo = "error"
            redirect(controller: 'login', action: "login")
            return
        } else {
            user = user.first()

            println "USER: " + user
            println "PASS: " + user.password
            println "PARM: " + params.pass
            println "PARM: " + params.pass.encodeAsMD5()

            if (params.pass.encodeAsMD5() != user.password) {
                flash.message = "Contrase�a incorrecta"
                flash.tipo = "error"
                flash.icon = "icon-warning"
                session.usuario = null
                session.departamento = null
                redirect(controller: 'login', action: "login")
                return
            }
            session.usuario = user
            session.time = new Date()
            doLogin_funcion()
        }
    }

    /**
     * Funci�n que hace el login: asigna el perfil y los permisos a la sesi�n y redirecciona a la pantalla de inicio
     * @param perfil
     * @return
     */
    def doLogin_funcion() {
        redirect(controller: "chat", action: "index")
    }

    /**
     * Acci�n que termina la sesi�n y redirecciona a la pantalla de login
     */
    def logout() {
        session.usuario = null
        session.menu = null
        session.an = null
        session.cn = null
        session.invalidate()
        redirect(controller: 'login', action: 'login')
    }
}
