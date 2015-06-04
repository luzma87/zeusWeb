package seguridad

class Persona {

    String nombre
    String apellido
    String cedula
    String email
    String password

    static mapping = {
        table 'prsn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort apellido: "asc"
        columns {
            id column: 'prsn__id'
            nombre column: 'prsnnmbr'
            apellido column: 'prsnapll'
            cedula column: 'prsncdla'
            password column: 'prsnpass'
        }
    }

    static constraints = {
        nombre maxSize: 30
        apellido maxSize: 30
        cedula size: 10..13
        email email: true
        password password: true
    }
}
