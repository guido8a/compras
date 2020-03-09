package compras

class DetalleProforma {

    Proforma proforma
    Item item
    double precioUnitario
    String procedencia

    static mapping = {
        table 'dtpf'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtpf__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtpf__id'
            proforma column: 'prfr__id'
            item column: 'item__id'
            precioUnitario column: 'dtpfpcun'
            procedencia column: 'dtpfobsr'
        }
    }
    static constraints = {
        proforma(blank: false, nullable: false, attributes: [title: 'proforma'])
        item(blank: false, nullable: false, attributes: [title: 'item'])
        precioUnitario(blank: false, nullable: false, attributes: [title: 'precio'])
        procedencia(size:1..255, blank: true, nullable: true, attributes: [title: 'procedencia'])
    }
}
