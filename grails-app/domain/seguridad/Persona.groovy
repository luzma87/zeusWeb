package seguridad

class Persona {

    String nombre
    String login
    String cedula
    String email
    String password
    String direccion
    Double longitud
    Double latitud
    String telefono
    String celular
    String creacion = new Date().getTime().toString()
    String modificacion= new Date().getTime().toString()
    String tipo

    static mapping = {
        table 'ofuser'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'ofuser__id'
            nombre column: 'name'
            login column: 'username'
            cedula column: 'cedula'
            email column: 'email'
            password column: 'encryptedPassword'
            direccion column: 'direccion'
            creacion column: 'creationDate'
            modificacion column: 'modificacionDate'

        }
    }

    static constraints = {
        nombre(size: 1..100,nullable: true,blank: true)
        login(size: 1..100,nullable: false,blank: false,unique: true)
        cedula(size: 10..13,nullable: true,blank: true)
        email(size: 10..13,nullable: true,blank: true)
        password(size: 1..255,nullable: true,blank: true)
        direccion(size: 1..500,nullable: true,blank: true)
        longitud(nullable: true)
        latitud(nullable: true)
        telefono(size: 1..13,nullable: true,blank: true)
        celular(size: 1..13,nullable: true,blank: true)
        creacion(size: 1..15,nullable: false,blank: false)
        modificacion(size: 1..15,nullable: false,blank: false)
        tipo(size: 1..1,nullable: true,blank: true)
    }
}
