package documentos

import seguridad.Shield

/**
 * Controlador que muestra las pantallas de manejo de DocumentoPersona
 */
class DocumentoPersonaController extends Shield {

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
            def c = DocumentoPersona.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                }
            }
        } else {
            list = DocumentoPersona.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList_funcion(params, all)
        }
        return list
    }

    /**
     * Acción llamada con ajax que muestra la lista de elementos
     */
    def list_ajax() {
        def documentoPersonaInstanceList = getList_funcion(params, false)
        def documentoPersonaInstanceCount = getList_funcion(params, true).size()
        return [documentoPersonaInstanceList: documentoPersonaInstanceList, documentoPersonaInstanceCount: documentoPersonaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def documentoPersonaInstance = DocumentoPersona.get(params.id)
            if (!documentoPersonaInstance) {
                render "ERROR*No se encontró DocumentoPersona."
                return
            }
            return [documentoPersonaInstance: documentoPersonaInstance]
        } else {
            render "ERROR*No se encontró DocumentoPersona."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def documentoPersonaInstance = new DocumentoPersona()
        if (params.id) {
            documentoPersonaInstance = DocumentoPersona.get(params.id)
            if (!documentoPersonaInstance) {
                render "ERROR*No se encontró DocumentoPersona."
                return
            }
        }
        documentoPersonaInstance.properties = params
        if (!documentoPersonaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar DocumentoPersona: " + renderErrors(bean: documentoPersonaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de DocumentoPersona exitosa."
        return
    } //save para grabar desde ajax
}
