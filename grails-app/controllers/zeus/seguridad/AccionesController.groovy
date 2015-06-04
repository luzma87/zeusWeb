package arazu.seguridad

class AccionesController extends Shield {

    /*
    <div>Icons made by <a href="http://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a>, <a href="http://www.flaticon.com/authors/vectorgraphit" title="Vectorgraphit">Vectorgraphit</a>, <a href="http://www.flaticon.com/authors/ocha" title="OCHA">OCHA</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a>             is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
     */

    /**
     * Acción que muestra un listado de acciones ordenadas por módulo
     */
    def acciones() {
        def modulos = Modulo.list([sort: "orden"])
        return [modulos: modulos]
    }

    /**
     * Acción que muestra una lista de acciones filtrando por módulo y tipo para editar las acciones
     */
    def acciones_ajax() {
        def perfil = Perfil.get(params.perf.toLong())
        def modulo = Modulo.get(params.id)

        def acciones = Accion.withCriteria {
            eq("modulo", modulo)
            order("tipo", "asc")
            if (modulo.nombre == "noAsignado") {
                control {
                    order("nombre", "asc")
                }
                order("nombre", "asc")
            } else {
                order("orden", "asc")
            }
        }

        def acp = acciones.findAll { Permiso.countByAccionAndPerfil(it, perfil) > 0 }
        def acnp = acciones.findAll { Permiso.countByAccionAndPerfil(it, perfil) == 0 }

        return [acciones: acp + acnp, perfil: perfil, modulo: modulo]
    }

    /**
     * Acción llamada con ajax que cambia el tipo de una acción entre Menú y Proceso
     */
    def accionCambiarTipo_ajax() {
        def accion = Accion.get(params.id)
        accion.tipo = TipoAccion.findByCodigo(params.tipo)
        if (!accion.save(flush: true)) {
            render "ERROR*" + renderErrors(bean: accion)
        } else {
            render "SUCCESS*Tipo de acción modificado exitosamente"
        }
    }

    /**
     * Acción llamada con ajax que cambia el nombre de varias acciones
     */
    def accionCambiarNombre_ajax() {
        def errores = ""
        def cont = 0

        params.each { k, v ->
            if (k.toString().startsWith("desc")) {
                def parts = k.split("_")
                if (parts.size() == 2) {
                    def id = parts[1].toLong()
                    def accion = Accion.get(id)
                    accion.descripcion = v.trim()
                    if (!accion.save(flush: true)) {
                        errores += renderErrors(bean: accion)
                    } else {
                        cont++
                    }
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Nombre de ${cont} acci${cont == 1 ? 'ón' : 'ones'} modificado${cont == 1 ? '' : 's'} exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción llamada con ajax que cambia el módulo al que pertenecen varias acciones
     */
    def accionCambiarModulo_ajax() {
        def errores = ""
        def cont = 0

        params.each { k, v ->
            if (k.toString().startsWith("mod")) {
                def parts = k.split("_")
                if (parts.size() == 2) {
                    def id = parts[1].toLong()
                    def accion = Accion.get(id)
                    accion.modulo = Modulo.get(v.toLong())
                    if (!accion.save(flush: true)) {
                        errores += renderErrors(bean: accion)
                    } else {
                        cont++
                    }
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Módulo de ${cont} acci${cont == 1 ? 'ón' : 'ones'} modificado${cont == 1 ? '' : 's'} exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción llamada con ajax que cambia el sistema al que pertenecen varias acciones
     */
    def accionCambiarSistema_ajax() {
        def errores = ""
        def cont = 0

        params.each { k, v ->
            if (k.toString().startsWith("sis")) {
                def parts = k.split("_")
                if (parts.size() == 2) {
                    def id = parts[1].toLong()
                    def accion = Accion.get(id)
                    if (v != "null") {
                        accion.sistema = Sistema.get(v.toLong())
                    } else {
                        accion.sistema = null
                    }
                    if (!accion.save(flush: true)) {
                        errores += renderErrors(bean: accion)
                    } else {
                        cont++
                    }
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Sistema de ${cont} acci${cont == 1 ? 'ón' : 'ones'} modificado${cont == 1 ? '' : 's'} exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción llamada con ajax que cambia el orden de una acción
     */
    def accionCambiarOrden_ajax() {
        def accion = Accion.get(params.id)
        accion.orden = params.orden.toInteger()
        if (accion.save(flush: true)) {
            render "SUCCESS*Se ha cambiado el orden exitosamente"
        } else {
            render "ERROR*" + renderErrors(bean: accion)
        }
    }

    /**
     * Acción llamada con ajax que cambia el icono de una acción
     */
    def accionCambiarIcono_ajax() {
        def accion = Accion.get(params.id)
        accion.icono = params.icono
        if (accion.save(flush: true)) {
            render "SUCCESS*Se ha cambiado el icono exitosamente"
        } else {
            render "ERROR*" + renderErrors(bean: accion)
        }
    }

    /**
     * Función que busca si un elemento existe con ilike
     * @param lista
     * @param elemento
     */
    def containsIlike_funcion(lista, String elemento) {
        def existe = false
        lista.each { String item ->
            if (elemento.matches("(?i).*" + item + ".*")) {
                existe = true
            }
        }
        return existe
    }

    /**
     * Acción llamada con ajax que itera sobre todos los controladores creados en el proyecto, analiza las acciones de cada controlador, las busca en la base de datos y si no las encuentra las inserta en la tabla representada por el dominio Accn
     */
    def cargarAcciones_ajax() {
        println "cargar acciones"
        def ac = []
        def accs = [:]
        def ok = 0
        def okc = 0
        def total = 0
        def ignoreAcciones = ["afterInterceptor", "beforeInterceptor"]
        def ignoreAccionesLike = ["ajax", "old", "funcion", "ignore"]
        def ignoreControladores = ["Assets", "Dbdoc", "Shield", "Login", "Pdf",
                                   "ReportesInventario", "ReportesPedidos", "ReportesPersonal"]
        def errores = ""

        def controladoresDelete = Controlador.list().id
        def accionesDelete = Accion.list().id

        grailsApplication.controllerClasses.each { ct ->
//            println "intenta con controller " + ct.getName() + "    contains??? " + (ignoreControladores.contains(ct.getName()))
            if (!ignoreControladores.contains(ct.getName())) {
                def t = []
                ct.getURIs().each {
                    def s = it.split("/")
                    if (s.size() > 2) {
//                        println "\tintenta con " + s
                        if (!t.contains(s[2])) {
                            if (!ignoreAcciones.contains(s[2])) {
                                if (!containsIlike_funcion(ignoreAccionesLike, s[2])) {
                                    if (!(s[2] =~ "Service")) {
                                        def ctrl = Controlador.findByNombreIlike(s[1])
                                        if (!ctrl) {
                                            ctrl = new Controlador()
                                            ctrl.nombre = s[1].toString().capitalize()
                                            if (ctrl.save(flush: true)) {
                                                okc++
                                            } else {
                                                errores += renderErrors(bean: ctrl)
                                                println "errores " + ctrl.errors
                                            }
                                        } else {
                                            controladoresDelete.remove(ctrl.id)
                                        }
                                        def accn = Accion.findByNombreAndControl(s[2], ctrl)
//                                        println "si service " + s[2] + " accion " + accn.id + " url " + it
                                        if (accn == null) {
//                                    println "if 2";
                                            accn = new Accion()
                                            accn.nombre = s[2]
                                            accn.control = Controlador.findByNombre(ct.getName())
                                            accn.descripcion = s[2]
                                            accn.esAuditable = 1
                                            accn.orden = 1
//                                    if (s[2] =~ "save" || s[2] =~ "update" || s[2] =~ "delete" || s[2] =~ "guardar")
                                            accn.tipo = TipoAccion.findByCodigo("P")
//                                    else
//                                        accn.tipo = TipoAccion.findByCodigo("M")
                                            accn.modulo = Modulo.findByNombre("noAsignado")
                                            if (accn.save(flush: true)) {
                                                accn.orden = accn.id
                                                accn.icono = ""
                                                accn.save(flush: true)
                                                ok++
                                            } else {
                                                errores += renderErrors(bean: accn)
                                                println "errores " + accn.errors
                                            }
                                            total++
                                        } else {
                                            accionesDelete.remove(accn.id)
                                        }
                                        t.add(s.getAt(2))
                                    } else {
//                                        println "no sale por el service " + s[2] + " " + it
                                    }
                                } else {
//                                    println s[2] + " no sale por el ignoreAccionesLike " + ignoreAccionesLike
                                }
                            } else {
//                                println s[2] + " no sale por el ignoreAcciones " + ignoreAcciones
                            }
                        } else {
//                            println "no sale por el contains t  " + it + "   " + t
                        }
                    } else {
//                        println "no sele por el size " + it
                    }
                }
                accs.put(ct.getName(), t)
                t = null
            } else {
//                println ct.getName() + " no sale por el ignoreControladores " + ignoreControladores
            }
        }

        def permisosEliminados = 0, accionesEliminadas = 0, controladoresEliminados = 0

        accionesDelete.each { aId ->
            def permisos = Permiso.findAllByAccion(Accion.get(aId))
            if (permisos.size() > 0) {
                permisos.id.each { pid ->
                    def p = Permiso.get(pid)
                    try {
                        println "eliminando permiso " + pid + "   (" + p.accion + " - " + p.perfil + ")"
                        p.delete(flush: true)
                        permisosEliminados++
                    } catch (e) {
                        println "Error al eliminar permiso"
                        e.printStackTrace()
                    }
                } //elimina permisos
            }
            def a = Accion.get(aId)
            try {
                println "eliminando accion " + aId + "      (" + a.control.nombre + "    " + a.nombre + ")"
                a.delete(flush: true)
                accionesEliminadas++
            } catch (e) {
                println "Error al eliminar accion"
                e.printStackTrace()
            }
        }
        controladoresDelete.each { cId ->
            def c = Controlador.get(cId)
            try {
                println "eliminando controlador " + cId + "     (" + c.nombre + ")"
                c.delete(flush: true)
                controladoresEliminados++
            } catch (e) {
                println "Error al eliminar controlador"
                e.printStackTrace()
            }
        }

        def msgExtra = ""
        if (permisosEliminados > 0) {
            msgExtra += "${permisosEliminados} permiso${permisosEliminados == 1 ? '' : 's'}"
        }
        if (accionesEliminadas > 0) {
            if (msgExtra != "") {
                msgExtra += ", "
            }
            msgExtra += "${accionesEliminadas} acci${accionesEliminadas == 1 ? 'ón' : 'ones'}"
        }
        if (controladoresEliminados > 0) {
            if (msgExtra != "") {
                msgExtra += ", "
            }
            msgExtra += "${controladoresEliminados} controlador${controladoresEliminados == 1 ? '' : 'es'}"
        }

        def totalEliminados = permisosEliminados + accionesEliminadas + controladoresEliminados
        if (totalEliminados > 0) {
            msgExtra = "Se elimin${totalEliminados == 1 ? 'ó' : 'aron'} además " + msgExtra
            if (accionesEliminadas > 0 && permisosEliminados == 0 && controladoresEliminados == 0) {
                msgExtra += " obsoleta${totalEliminados == 1 ? '' : 's'}"
            } else {
                msgExtra += " obsoleto${totalEliminados == 1 ? '' : 's'}"
            }
        }

//        println "" + permisosEliminados + "   " + accionesEliminadas + "    " + controladoresEliminados + "   " + totalEliminados + "    " + msgExtra

        if (errores == "") {
            def msg = "SUCCESS*Se ha${(ok + okc) == 1 ? '' : 'n'} agregado ${ok} acci${ok == 1 ? 'ón' : 'ones'} ${okc == 0 ? '' : (' y ' + okc + ' controlador' + (okc == 1 ? '' : 'es'))}"
            msg += ". " + msgExtra
            render msg
        } else {
            def msg = "ERROR*Se insert${ok == 1 ? 'ó' : 'aron'} ${ok} de ${total} acci${ok == 1 ? 'ón' : 'ones'}: " + errores
            msg += ". " + msgExtra
            render msg
        }
    }

    /**
     * Acción llamada con ajax que guarda los permisos de un perfil
     */
    def guardarPermisos_ajax() {
        def perfil = Perfil.get(params.perfil.toLong())
        def modulo = Modulo.get(params.modulo.toLong())

        //todos los permisos actuales de este perfil en este modulo
        def permisosOld = Permiso.withCriteria {
            eq("perfil", perfil)
            accion {
                eq("modulo", modulo)
            }
        }
        def accionesSelected = []
        def accionesInsertar = []
        (params.accion.split(",")).each { accionId ->
            if (accionId) {
                def accion = Accion.get(accionId.toLong())
                if (!permisosOld.accion.id.contains(accion.id)) {
                    accionesInsertar += accion
                } else {
                    accionesSelected += accion
                }
            }
        }

        def commons = permisosOld.accion.intersect(accionesSelected)
        def accionesDelete = permisosOld.accion.plus(accionesSelected)
        accionesDelete.removeAll(commons)

        def errores = ""

        accionesInsertar.each { accion ->
            def perm = new Permiso()
            perm.accion = accion
            perm.perfil = perfil
            if (!perm.save(flush: true)) {
                errores += renderErrors(bean: perm)
                println "error al guardar permiso: " + perm.errors
            }
        }
        accionesDelete.each { accion ->
            def perm = Permiso.findAllByPerfilAndAccion(perfil, accion)
            try {
                if (perm.size() == 1) {
                    perm.first().delete(flush: true)
                } else {
                    errores += "Existen ${perm.size()} registros del permiso " + accion.nombre
                }
            } catch (Exception e) {
                errores += "Ha ocurrido un error al eliminar el permiso " + accion.nombre
                println "error al eliminar permiso: " + e
            }
        }
        if (errores == "") {
            render "SUCCESS*${accionesInsertar.size()} acci${accionesInsertar.size() == 1 ? 'ón' : 'ones'} insertada${accionesInsertar.size() == 1 ? '' : 's'}" +
                    " y ${accionesDelete.size()} acci${accionesDelete.size() == 1 ? 'ón' : 'ones'} eliminada${accionesDelete.size() == 1 ? '' : 's'} exitosamente"
        } else {
            render "ERROR*" + errores
        }

        def lg = new LoginController()
        lg.cargarPermisos()
    }
}
