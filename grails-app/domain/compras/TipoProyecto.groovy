package compras

class TipoProyecto {

    String descripcion
    Date fechaInicio
    Date fechaFin
    static auditable = true
    static mapping = {
        table 'tppy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tppy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tppy__id'
            descripcion column: 'tppydscr'
            fechaFin column: 'tppyfcfn'
            fechaInicio column: 'tppyfcin'
        }
    }
    static constraints = {
        descripcion(size: 1..40, unique: true, blank: false, attributes: [title: 'descripcion'])
        fechaInicio(blank:true, nullable: true)
        fechaFin(blank:true, nullable: true)
    }
}
