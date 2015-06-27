package mensajes

import org.springframework.dao.DataIntegrityViolationException
import seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de MensajeComunidad
 */
class MensajeComunidadController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    List<MensajeComunidad> getList_funcion(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = MensajeComunidad.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("contenido", "%" + params.search + "%")
                    ilike("resumen", "%" + params.search + "%")
                }
            }
        } else {
            list = MensajeComunidad.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList_funcion(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     */
    def list() {
        def mensajeComunidadInstanceList = getList_funcion(params, false)
        def mensajeComunidadInstanceCount = getList_funcion(params, true).size()
        return [mensajeComunidadInstanceList: mensajeComunidadInstanceList, mensajeComunidadInstanceCount: mensajeComunidadInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def mensajeComunidadInstance = MensajeComunidad.get(params.id)
            if (!mensajeComunidadInstance) {
                render "ERROR*No se encontró Mensaje a la Comunidad."
                return
            }
            return [mensajeComunidadInstance: mensajeComunidadInstance]
        } else {
            render "ERROR*No se encontró Mensaje a la Comunidad."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def mensajeComunidadInstance = new MensajeComunidad()
        if (params.id) {
            mensajeComunidadInstance = MensajeComunidad.get(params.id)
            if (!mensajeComunidadInstance) {
                render "ERROR*No se encontró Mensaje a la Comunidad."
                return
            }
        }
        mensajeComunidadInstance.properties = params
        return [mensajeComunidadInstance: mensajeComunidadInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def mensajeComunidadInstance = new MensajeComunidad()
        if (params.id) {
            mensajeComunidadInstance = MensajeComunidad.get(params.id)
            if (!mensajeComunidadInstance) {
                render "ERROR*No se encontró Mensaje a la Comunidad."
                return
            }
        }
        mensajeComunidadInstance.properties = params
        if (!mensajeComunidadInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Mensaje a la Comunidad: " + renderErrors(bean: mensajeComunidadInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Mensaje a la Comunidad exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def mensajeComunidadInstance = MensajeComunidad.get(params.id)
            if (!mensajeComunidadInstance) {
                render "ERROR*No se encontró Mensaje a la Comunidad."
                return
            }
            try {
                mensajeComunidadInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Mensaje a la Comunidad exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Mensaje a la Comunidad"
                return
            }
        } else {
            render "ERROR*No se encontró Mensaje a la Comunidad."
            return
        }
    } //delete para eliminar via ajax

}
