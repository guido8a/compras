package compras

class Criterio {

    String descripcion

    static mapping = {
        table 'crtr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crtr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'crtr__id'
            descripcion column: 'crtrdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..15, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
