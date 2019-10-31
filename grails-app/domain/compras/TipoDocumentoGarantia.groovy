package compras

class TipoDocumentoGarantia {

    String descripcion
    static auditable = true

    static  mapping = {

        table 'tdgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tdgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tdgr__id'
            descripcion column: 'tdgrdscr'
        }
    }

    static constraints = {
        descripcion(size: 1..31, blank: true, nullable: true, attributes: [title: 'descripción'])
    }
}
