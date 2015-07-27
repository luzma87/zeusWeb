package documentos

class Documento {

    String nombre
    String descripcion

    static mapping = {
        table 'dcmt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dcmt__id'
            nombre column: 'dcmtnmbr'
            descripcion column: 'dcmtdscr'
        }
    }

    static constraints = {
        nombre maxSize: 30
        descripcion nullable: true, maxSize: 140
    }

    public String toString() {
        return this.nombre
    }
}
