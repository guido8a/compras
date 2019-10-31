package compras

class Proveedor  {

    Canton canton
    String tipo //persona natural o jurídica
    String ruc //ruc o cédula dependiendo del tipo
    String nombre //nombre de la empresa (nulo si es persona natural)
    String nombreContacto //nombre del contacto o de la persona natural
    String apellidoContacto //apellido del contacto o de la persona natural
    String direccion
    String telefonos //ejemple 097438273 – 096234124 - 022234123
    Date fechaContacto //fecha de contacto o registro
    String email
    String licencia //número de licencia profesional del colegio de ingenieros
    String camara //número de registro en la cámara de la construcción
    String titulo //título profesional del titular
    String estado //activo o inactivo
    String observaciones
    static auditable = true

    static mapping = {
        table 'prve'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prve__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prve__id'
            canton column: 'cntn__id'
            tipo column: 'prvetipo'
            ruc column: 'prve_ruc'
            nombre column: 'prvenmbr'
            nombreContacto column: 'prvenbct'
            apellidoContacto column: 'prveapct'
            direccion column: 'prvedire'
            telefonos column: 'prvetelf'
            fechaContacto column: 'prvefccn'
            email column: 'prvemail'
            licencia column: 'prveclig'
            camara column: 'prvecmra'
            titulo column: 'prvettlr'
            estado column: 'prveetdo'
            observaciones column: 'prveobsr'
        }
    }
    static constraints = {
        tipo(blank: true, nullable: true, maxSize: 1, inList: ['N', 'J', 'E'])
        ruc(blank: true, nullable: true, maxSize: 13)
        nombre(blank: true, nullable: true, maxSize: 63)
        nombreContacto(blank: true, nullable: true, maxSize: 31)
        apellidoContacto(blank: true, nullable: true, maxSize: 31)
        direccion(blank: true, nullable: true, maxSize: 60)
        telefonos(blank: true, nullable: true, maxSize: 40)
        fechaContacto(blank: true, nullable: true)
        email(blank: true, nullable: true, maxSize: 40)
        licencia(blank: true, nullable: true, maxSize: 10)
        camara(blank: true, nullable: true, maxSize: 7)
        titulo(blank: true, nullable: true, maxSize: 4)
        estado(blank: true, nullable: true, maxSize: 1)
        observaciones(blank: true, nullable: true, maxSize: 127)
        canton(blank: false, nullable: false)
    }

    String toString() {
        return "${this.nombre}"
    }




//    Canton canton
//    String nombre
//    String sigla
//    String direccion
//    String telefono
//    Date fechaContacto
//    String ruc
//    String observaciones
//    String indiceCostosIndirectosGarantias
//    String email
//    String tituloProfecionalTitular
//    String tipo
//    String apellidoContacto
//    static mapping = {
//        table 'prve'
//        cache usage: 'read-write', include: 'non-lazy'
//        id column: 'prve__id'
//        id generator: 'identity'
//        version false
//        columns {
//            id column: 'prve__id'
//            ruc column: 'prve_ruc'
//            nombre column: 'prvenmbr'
//            sigla column: 'prvesgla'
//            direccion column: 'prvedire'
//            telefono column: 'prvetelf'
//            fechaContacto column: 'prvefccn'
//            observaciones column: 'prveobsr'
//            indiceCostosIndirectosGarantias column: 'prvegrnt'
//            email column: 'prvemail'
//            tituloProfecionalTitular column: 'prvettlr'
//            canton column: 'cntn__id'
//            tipo column: 'prvetipo'
//        }
//    }
//    static constraints = {
//
//        nombre(size: 1..20, blank: false, nullable: false, attributes: [title: 'nombre'])
//        sigla(size: 1..6, blank: true, nullable: true, attributes: [title: 'sigla'])
//        ruc(size: 1..13, blank: false, nullable: false, attributes: [title: 'ruc'])
//        direccion(size: 1..60, blank: true, nullable: true, attributes: [title: 'direccion'])
//        telefono(size: 1..40, blank: true, nullable: true, attributes: [title: 'telefono'])
//        email(size: 1..40, blank: true, nullable: true, attributes: [title: 'email'])
//        fechaContacto(blank: true, nullable: true, attributes: [title: 'fechaContacto'])
//        indiceCostosIndirectosGarantias(size: 1..40, blank: true, nullable: true, attributes: [title: 'indiceCostosIndirectosGarantias'])
//        tituloProfecionalTitular(size: 1..4, blank: true, nullable: true, attributes: [title: 'tituloProfecionalTitular'])
//        observaciones(size: 1..60, blank: true, nullable: true, attributes: [title: 'observaciones'])
//        canton(blank: false, nullable: false)
//        tipo(blank: false, nullable: false, size: 1..1)
//    }
}