package seguridad

import org.springframework.dao.DataIntegrityViolationException



/**
 * Controlador que muestra las pantallas de manejo de Persona
 */
class PersonaController {

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
        if(all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if(params.search) {
            def c = Persona.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("cedula", "%" + params.search + "%")  
                    ilike("celular", "%" + params.search + "%")  
                    ilike("creacion", "%" + params.search + "%")  
                    ilike("direccion", "%" + params.search + "%")  
                    ilike("email", "%" + params.search + "%")  
                    ilike("login", "%" + params.search + "%")  
                    ilike("modificacion", "%" + params.search + "%")  
                    ilike("nombre", "%" + params.search + "%")  
                    ilike("telefono", "%" + params.search + "%")  
                    ilike("tipo", "%" + params.search + "%")  
                }
            }
        } else {
            list = Persona.list(params)
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
        def personaInstanceList = getList_funcion(params, false)
        def personaInstanceCount = getList_funcion(params, true).size()
        return [personaInstanceList: personaInstanceList, personaInstanceCount: personaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if(params.id) {
            def personaInstance = Persona.get(params.id)
            if(!personaInstance) {
                render "ERROR*No se encontró Persona."
                return
            }
            return [personaInstance: personaInstance]
        } else {
            render "ERROR*No se encontró Persona."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def personaInstance = new Persona()
        if(params.id) {
            personaInstance = Persona.get(params.id)
            if(!personaInstance) {
                render "ERROR*No se encontró Persona."
                return
            }
        }
        personaInstance.properties = params
        return [personaInstance: personaInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def personaInstance = new Persona()
        if(params.id) {
            personaInstance = Persona.get(params.id)
            if(!personaInstance) {
                render "ERROR*No se encontró Persona."
                return
            }
        }
        personaInstance.properties = params
        if(!personaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Persona: " + renderErrors(bean: personaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Persona exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if(params.id) {
            def personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                render "ERROR*No se encontró Persona."
                return
            }
            try {
                personaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Persona exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Persona"
                return
            }
        } else {
            render "ERROR*No se encontró Persona."
            return
        }
    } //delete para eliminar via ajax
    
    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad email
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_email_ajax() {
        params.email = params.email.toString().trim()
        if (params.id) {
            def obj = Persona.get(params.id)
            if (obj.email.toLowerCase() == params.email.toLowerCase()) {
                render true
                return
            } else {
                render Persona.countByEmailIlike(params.email) == 0
                return
            }
        } else {
            render Persona.countByEmailIlike(params.email) == 0
            return
        }
    }
        
    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad login
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_login_ajax() {
        params.login = params.login.toString().trim()
        if (params.id) {
            def obj = Persona.get(params.id)
            if (obj.login.toLowerCase() == params.login.toLowerCase()) {
                render true
                return
            } else {
                render Persona.countByLoginIlike(params.login) == 0
                return
            }
        } else {
            render Persona.countByLoginIlike(params.login) == 0
            return
        }
    }
        
}
