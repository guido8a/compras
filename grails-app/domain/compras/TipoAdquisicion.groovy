package compras

class TipoAdquisicion {

    String codigo
    String descripcion

    static mapping = {
        table 'tpad'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpad__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpad__id'
            codigo column: 'tpadcdgo'
            descripcion column: 'tpaddscr'

        }
    }

    static constraints = {
        descripcion(size: 1..63, blank: false, attributes: [title: 'nombre'])
        codigo(size: 1..6, unique: true, blank: false, attributes: [title: 'numero'])
    }
}
