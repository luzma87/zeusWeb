package arazu.seguridad

class LoginController {

    /**
     * Acción que valida que la sesión esté activa
     */
    def validarSesion() {
        println "sesion creada el:" + new Date(session.getCreationTime()) + " hora actual: " + new Date()
        println "último acceso:" + new Date(session.getLastAccessedTime()) + " hora actual: " + new Date()

        println session.usuario
        if (session.usuario) {
            render "OK"
        } else {
            flash.message = "Su sesión ha caducado, por favor ingrese nuevamente."
            render "NO"
        }
    }

    /**
     * Acción que muestra la pantalla de login
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
     * Acción que valida las credenciales de login. Si el usuario tiene un solo perfil, inicia directamente la sesión, sino muestra la pantalla de selección de perfil
     */
    def validar() {
        if (!params.user || !params.pass) {
            redirect(controller: "login", action: "login")
            return
        }
        def user = Persona.withCriteria {
            ilike("login", params.user)
            eq("activo", 1)
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
            def perfiles = Sesion.findAllByUsuario(user)
            if (perfiles.size() == 0) {
                flash.message = "No puede ingresar porque no tiene ningún perfil asignado a su usuario. Comuníquese con el administrador."
                flash.tipo = "error"
                flash.icon = "icon-warning"
                session.usuario = null
                session.departamento = null
                redirect(controller: 'login', action: "login")
                return
            } else {
                if (params.pass.encodeAsMD5() != user.password) {
                    flash.message = "Contraseña incorrecta"
                    flash.tipo = "error"
                    flash.icon = "icon-warning"
                    session.usuario = null
                    session.departamento = null
                    redirect(controller: 'login', action: "login")
                    return
                }
            }
            session.usuario = user
            session.usuarioKerberos = user.login
            session.time = new Date()
            session.departamento = user.tipoUsuario
            if (perfiles.size() == 1) {
                doLogin_funcion(perfiles.first().perfil)
            } else {
                redirect(action: "perfiles")
                return
            }
        }
    }

    /**
     * Función que hace el login: asigna el perfil y los permisos a la sesión y redirecciona a la pantalla de inicio
     * @param perfil
     * @return
     */
    def doLogin_funcion(perfil) {
        session.perfil = perfil
        cargarPermisos()

        if (session.an && session.cn) {
            redirect(controller: session.cn, action: session.an, params: session.pr)
        } else {
            redirect(controller: "sistema", action: "index")
        }
        return
    }

    /**
     * Acción que muestra la pantalla de selección de perfil
     */
    def perfiles() {
        def usuarioLog = session.usuario
//        def perfilesUsr = Sesn.findAllByUsuario(usuarioLog, [sort: 'perfil'])
//        def perfiles = []
//        perfilesUsr.each { p ->
//            perfiles.add(p)
//        }

        def perfiles = Sesion.withCriteria {
            eq("usuario", usuarioLog)
            perfil {
                order("nombre", "asc")
            }
        }.perfil

        return [perfiles: perfiles]
    }

    /**
     * Acción que guarda el perfil y hace el login
     */
    def savePerfil() {
        if (!params.perfil) {
            redirect(controller: "inicio", action: "perfiles")
        }
        def perfil = Perfil.get(params.perfil)
        doLogin_funcion(perfil)
    }

    /**
     * Acción que termina la sesión y redirecciona a la pantalla de login
     */
    def logout() {
        session.usuario = null
        session.perfil = null
        session.permisos = null
        session.menu = null
        session.an = null
        session.cn = null
        session.invalidate()
        redirect(controller: 'login', action: 'login')
    }

    /**
     * Acción que carga los permisos del perfil del usuario en la sesión para validar las pantallas a las que puede acceder
     */
    def cargarPermisos() {
        def permisos = Permiso.findAllByPerfil(session.perfil)
        def hp = [:]
        permisos.each {
            if (hp[it.accion.control.nombre.toLowerCase()]) {
                hp[it.accion.control.nombre.toLowerCase()].add(it.accion.nombre.toLowerCase())
            } else {
                hp.put(it.accion.control.nombre.toLowerCase(), [it.accion.nombre.toLowerCase()])
            }
        }
        def sistemas = permisos.accion.sistema.unique().sort { it?.orden }
        session.sistemas = sistemas
        def ss = []
        sistemas.each { s ->
            if (s) {
                ss += s
            }
        }
        if (ss.size() == 1) {
            session.sistema = ss.first()
        }
//        println "sistema en login: " + ss
        session.permisos = hp
    }
}
