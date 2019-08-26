package compras

//import audita.Auditable
import seguridad.Departamento
import seguridad.Persona

//class Alerta implements Auditable {
class Alerta {
    static auditable = true
    Persona persona
    Departamento departamento
    String mensaje
    String accion
    Date fechaCreacion = new Date()
    Date fechaRecibido
//    Actividad actividad

    static mapping = {
        table 'alrt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'alrt__id'
            persona column: 'prsn__id'
            departamento column: 'dpto__id'
            mensaje column: 'alrtmnsj'
            accion column: 'altraccn'
            fechaCreacion column: 'altrfccr'
            fechaRecibido column: 'altrfcrc'
            actividad column: 'actv__id'
        }

    }

    static constraints = {
        persona(nullable: true, blank: true)
        departamento(nullable: true, blank: true)
        mensaje(size: 1..511, nullable: false, blank: false)  //puede ser por lo menos un "ok"
        accion(size: 1..255, nullable: true, blank: true)
        fechaRecibido(nullable: true, blank: true)
        fechaCreacion(nullable: false, blank: false)
        actividad(nullable: true, blank: true)
    }

    String toString() {
        "${this.persona} - ${this.mensaje} "
    }
}
