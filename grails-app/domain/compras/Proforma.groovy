package compras

class Proforma {
    Proveedor proveedor
    String descripcion
    Date fecha
    int plazo
    String calificacion
    String estado
    String observaciones

    static mapping = {
        table 'prfr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prfr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prfr__id'
            proveedor column: 'prve__id'
            descripcion column: 'prfrdscr'
            fecha column: 'prfrfcen'
            plazo column: 'prfrplzo'
            calificacion column: 'prfrcalf'
            estado column: 'prfretdo'
            observaciones column: 'prfrobsr'
        }
    }
    static constraints = {
        descripcion(size: 1..255, blank: false, attributes: [title: 'descripcion'])
        calificacion(blank: true, nullable: true, attributes: [title: 'calificacion'])
        observaciones(blank: true, nullable: true, attributes: [title: 'observacion'])
    }
    String toString() {
        descripcion
    }
}

