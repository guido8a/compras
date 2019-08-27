package compras

class Zona {

    int numero
    double longitud
    double latitud
    String nombre

    static mapping = {
        table 'zona'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'zona__id'
            numero column: 'zonanmro'
            longitud column: 'zonalong'
            latitud column: 'zonalatt'
            nombre column: 'zonanmbr'
        }

    }
    static constraints = {
        numero(blank: false, nullable: false)
        nombre(blank: false, nullable: false)
    }
}
