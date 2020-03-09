package compras

class Precio {

    DetalleProforma detalleProforma
    DetalleProyecto detalleProyecto
    DetalleProyecto detallePrecio
    double valor

    static mapping = {
        table 'prco'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prco__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prco__id'
            detalleProforma column: 'dtpf__id'
            detalleProyecto column: 'dtpy__id'
            detallePrecio column: 'dtpypcun'
            valor column: 'prcovlor'
        }
    }
    static constraints = {
        detalleProforma(blank: true, nullable: true, attributes: [title: 'Desde proforma'])
        detalleProyecto(blank: true, nullable: true, attributes: [title: 'Desde proyecto'])
        detallePrecio(blank: true, nullable: true, attributes: [title: 'precio final'])
        valor(blank: false, nullable: false)
    }
}
