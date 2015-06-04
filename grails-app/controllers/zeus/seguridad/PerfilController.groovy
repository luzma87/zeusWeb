package arazu.seguridad

import org.springframework.dao.DataIntegrityViolationException

/**
 * Controlador que muestra las pantallas de manejo de Prfl
 */
class PerfilController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]
    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList_funcion(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Perfil.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                    ilike("observaciones", "%" + params.search + "%")
                }
            }
        } else {
            list = Perfil.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList_funcion(params, all)
        }
        return list
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return prflInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def prflInstance = Perfil.get(params.id)
            if (!prflInstance) {
                render "ERROR*No se encontró Perfil."
                return
            }
            return [prflInstance: prflInstance]
        } else {
            render "ERROR*No se encontró Perfil."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return prflInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def prflInstance = new Perfil()
        if (params.id) {
            prflInstance = Perfil.get(params.id)
            if (!prflInstance) {
                render "ERROR*No se encontró Perfil."
                return
            }
        }
        prflInstance.properties = params
        return [prflInstance: prflInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def prflInstance = new Perfil()
        if (params.id) {
            prflInstance = Perfil.get(params.id)
            if (!prflInstance) {
                render "ERROR*No se encontró Perfil."
                return
            }
        }
        prflInstance.properties = params
        if (!prflInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Perfil: " + renderErrors(bean: prflInstance)
            return
        }
        def c = 0
        def msgExtra = ""
        if (params.copiar) {
            def prflCopiar = Perfil.get(params.copiar.toLong())
            (Permiso.findAllByPerfil(prflCopiar)).each { perm ->
                def permiso = new Permiso()
                permiso.perfil = prflInstance
                permiso.accion = perm.accion
                if (permiso.save(flush: true)) {
                    c++
                } else {
                    msgExtra += renderErrors(bean: permiso)
                }
            }
            if (c > 0) {
                msgExtra += "<br/>Se copiaron ${c} permiso${c == 1 ? '' : 's'} del perfil ${prflCopiar.nombre}"
            }
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Perfil exitosa. " + msgExtra
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def prflInstance = Perfil.get(params.id)
            if (!prflInstance) {
                render "ERROR*No se encontró Perfil."
                return
            }
            try {
                prflInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Perfil exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Perfil"
                return
            }
        } else {
            render "ERROR*No se encontró Perfil."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigo
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigo_ajax() {
        params.codigo = params.codigo.toString().trim()
        if (params.id) {
            def obj = Perfil.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Perfil.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Perfil.countByCodigoIlike(params.codigo) == 0
            return
        }
    }
}
