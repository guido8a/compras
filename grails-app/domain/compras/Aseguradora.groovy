package compras

class Aseguradora {

    TipoAseguradora tipo
    String nombre
    String telefonos
    String mail
    String responsable
    Date fechaContacto
    String direccion
    String observaciones
    static auditable = true

    static mapping = {

        table 'asgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'asgr__id'
        id generator: 'identity'
        version false

        columns {
            id column: 'asgr__id'
            nombre column: 'asgrnmbr'
            tipo column: 'tpas__id'
            telefonos column: 'asgrtelf'
            mail column: 'asgrmail'
            responsable column: 'asgrrspn'
            fechaContacto column: 'asgrfccn'
            direccion column: 'asgrdire'
            observaciones column: 'asgrobsr'
        }
    }
    static constraints = {
        nombre(size: 1..61, blank: true, attributes: [title: 'nombre'])
        telefonos(size: 1..63, blank: true, nullable: true, attributes: [title: 'telefonos'])
        mail(size: 1..63, blank: true, nullable: true, attributes: [title: 'mail'])
        responsable(size: 1..63, blank: true, nullable: true, attributes: [title: 'responsable'])
        fechaContacto(blank: true, nullable: true, attributes: [title: 'fechaContacto'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
        tipo(blank: true, nullable: true, attributes: [title: 'observaciones'])

    }
}

