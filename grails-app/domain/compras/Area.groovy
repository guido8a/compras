package compras

class Area {

    String descripcion
    static mapping = {
        table 'area'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'area__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'area__id'
            descripcion column: 'areadscr'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
