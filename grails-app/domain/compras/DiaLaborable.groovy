package compras

class DiaLaborable {
    Date fecha
    String dia              //lun:1, mar:2, mie:3, jue:4, vie:5, sab:6, dom:0
    Anio anio            //anio de la fecha (para facilitar las busquedas)
    Integer ordinal
    static auditable = true
    static mapping = {
        table 'ddlb'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ddlb__id'
        id generator: 'identity'
        version false
        columns {
            fecha column: "ddlbfcha"
            dia column: "ddlbddia"
            anio column: "anio__id"
            ordinal column: "ddlbordn"
        }
    }
    static constraints = {
        dia(blank: false, nullable: false, maxSize: 3)
    }
}
