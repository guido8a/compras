package seguridad

class Departamento {
    static auditable = true
    Direccion direccion
    Departamento padre
    String codigo
    String nombre
    String telefono
    String extension
    String localizacion
    String estado /* para controlar departamentos con muchas actividades vencidas */
    Integer activo //1-> activo 0-> inactivo
    int orden = 0



    static mapping = {
        table 'dpto'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dpto__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dpto__id'
            direccion column: 'dire__id'
            padre column: 'dptopdre'
            codigo column: 'dptocdgo'
            nombre column: 'dptodscr'
            telefono column: 'dptotelf'
            extension column: 'dptoextn'
            localizacion column: 'dptodire'
            estado column: 'dptoetdo'
            activo column: 'dptoactv'
            orden column: 'dptoordn'
        }
    }
    static constraints = {
        padre(blank: true, nullable: true, attributes: [title: 'padre'])
        codigo(size: 1..15, unique: false, blank: false, attributes: [title: 'codigo'])
        nombre(size: 1..127, blank: false, attributes: [title: 'descripcion'])
        telefono(size: 1..62, blank: true, nullable: true, attributes: [title: 'telefono'])
        extension(maxSize: 7, blank: true, nullable: true, attributes: [title: 'extension'])
        direccion(blank: false, nullable: false, attributes: [title: 'direccion'])
        estado(blank: true, nullable: true, size: 1..1)
        localizacion(blank: true, nullable: true)
    }

    String toString() {
        return "${this.nombre}"
    }

    def getEstaActivo() {
        return this.activo == 1
    }

}