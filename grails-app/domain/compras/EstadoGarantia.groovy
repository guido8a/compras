package compras

class EstadoGarantia {

    String descripcion

    static auditable = true
    static mapping = {
        table 'edgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'edgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'edgr__id'
            descripcion column: 'edgrdscr'
        }
    }

    static constraints = {
        descripcion(size: 1..31, blank: true, nullable: true, attributes: [title: 'descripción'])
    }
}
