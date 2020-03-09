package compras

class Subpresupuesto {

    String descripcion
    static mapping = {
        table 'sbpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sbpr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'sbpr__id'
            descripcion column: 'sbprdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
