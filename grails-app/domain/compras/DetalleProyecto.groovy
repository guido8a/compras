package compras

class DetalleProyecto {

    Proyecto proyecto
    Item item
    Criterio criterio
    Criterio criterioProforma
    Criterio criterioProyecto
    double cantidad
    int orden
    double precioUnitario
    double subtotal
    double precioProyecto
    double precioProforma
    String fuente = null
    static mapping = {
        table 'dtpy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtpy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtpy__id'
            proyecto column: 'proy__id'
            item column: 'item__id'
            criterio column: 'crtr__id'
            criterioProforma column: 'crtrprfr'
            criterioProyecto column: 'crtrproy'
            cantidad column: 'dtpycntd'
            orden column: 'dtpyordn'
            precioUnitario column: 'dtpypcun'
            subtotal column: 'dtpysbtt'
            precioProyecto column: 'dtpypupy'
            precioProforma column: 'dtpypupf'
            fuente column: 'dtpyfnte'
        }
    }
    static constraints = {
        proyecto(blank: false, nullable: false, attributes: [title: 'proyecto'])
        item(blank: false, nullable: false, attributes: [title: 'item'])
        criterio(blank: true, nullable: true)
        criterioProyecto(blank: true, nullable: true)
        criterioProforma(blank: true, nullable: true)
        cantidad(blank: true, nullable: true)
        orden(blank: false, nullable: false)
        precioUnitario(blank: false, nullable: false)
        precioProyecto(blank: true, nullable: true)
        precioProforma(blank: true, nullable: true)
        subtotal(blank: true, nullable: true)
        fuente(blank: true, nullable: true)
    }
}
