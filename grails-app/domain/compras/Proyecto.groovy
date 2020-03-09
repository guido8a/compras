package compras

import seguridad.Departamento
import seguridad.Persona

class Proyecto {

    Proyecto padre
    Departamento unidadRequirente
    Item volquete
    Item chofer
    Lugar lugar
    Comunidad comunidad
    TipoProyecto tipoProyecto
    TipoAdquisicion tipoAdquisicion
    Persona responsable
    Persona revisor
    Persona inspector
    String codigo
    String nombre
    String descripcion
    Date fechaInicio
    Date fechaFin
    double distanciaPeso
    double distanciaVolumen
    double distancia
    double latitud
    double longitud
    String estado
    String referencia
    Date fechaCreacion
    String oficioIngreso
    String oficioSalida
    String observaciones
    Date fechaPrecios
    String memoCantidadObra
    String memoSalida
    Date fechaOficioSalida
    String sitio
    double valor
    String memoCertificacionPartida
    String memoActualizacionPrefecto
    String memoPartidaPresupuestaria
    int porcentajeAnticipo
    CodigoComprasPublicas codigoComprasPublicas
    String origen
    String caracteristicasTecnicas
    String sitioEntrega

    static auditable = true
    static mapping = {
        table 'proy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'proy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'proy__id'
            padre column: 'proypdre'
            unidadRequirente column: 'dpto__id'
            volquete column: 'proyvlqt'
            chofer column: 'proychfr'
            lugar column: 'lgar__id'
            comunidad column: 'cmnd__id'
            tipoProyecto column: 'tppy__id'
            tipoAdquisicion column: 'tpad__id'
            responsable column: 'prsn__id'
            revisor column: 'prsnrvsr'
            inspector column: 'prsninsp'
            codigo column: 'proycdgo'
            nombre column: 'proynmbr'
            descripcion column: 'proydscr'
            fechaInicio column: 'proyfcin'
            fechaFin column: 'proyfcfn'
            distanciaPeso column: 'proydsps'
            distanciaVolumen column: 'proydsvl'
            latitud column: 'proylatt'
            longitud column: 'proylong'
            estado column: 'proyetdo'
            referencia column: 'proyrefe'
            fechaCreacion column: 'proyfcha'
            oficioIngreso column: 'proyofig'
            oficioSalida column: 'proyofsl'
            observaciones column: 'proyobsr'
            fechaPrecios column: 'rbpcfcha'
            memoCantidadObra column: 'proymmco'
            memoSalida column: 'proymmsl'
            fechaOficioSalida column: 'proyfcsl'
            sitio column: 'proysito'
            valor column: 'proyvlor'
            memoCertificacionPartida column: 'proymmpr'
            memoActualizacionPrefecto column: 'proyprft'
            memoPartidaPresupuestaria column: 'proymmfn'
            porcentajeAnticipo column: 'proyantc'
            codigoComprasPublicas column: 'cpac__id'
            origen column: 'proyorig'
            caracteristicasTecnicas column: 'proycrtr'
            distancia column: 'proydstc'
            sitioEntrega column: 'proysten'

        }
    }

    static constraints = {

        unidadRequirente(blank: false, nullable: false)
        volquete(blank: true, nullable: true, attributes: [title: 'item-volquete'])
        chofer(blank: true, nullable: true, attributes: [title: 'itemChofer'])
        lugar(blank: true, nullable: true, attributes: [title: 'lugar'])
        comunidad(blank: true, nullable: true, attributes: [title: 'comunidad'])
        tipoProyecto(blank:false, nullable: false, attributes:[title: 'tipoProyecto'])
        tipoAdquisicion(blank:true, nullable: true, attributes:[title: 'tipoAdquisicion'])
        responsable(blank: true, nullable: true, attributes: [title: 'responsableObra'])
        revisor(blank: true, nullable: true, attributes: [title: 'revisor'])
        inspector(blank: true, nullable: true, attributes: [title: 'inspector'])
        codigoComprasPublicas(blank:true, nullable: true)

        padre(blank:true, nullable: true)
        codigo(size: 1..15, blank: false, nullable: false, attributes: [title: 'codigo'])
        nombre(size: 1..127, blank: false, nullable: false, attributes: [title: 'nombre'])
        descripcion(size: 1..511, blank: true, nullable: true, attributes: [title: 'descripcion'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fechaInicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'fechaFin'])
        distanciaPeso(blank: true, nullable: true, attributes: [title: 'distanciaPeso'])
        distanciaVolumen(blank: true, nullable: true, attributes: [title: 'distanciaVolumen'])
        latitud(blank: true, nullable: true, attributes: [title: 'latitud'])
        longitud(blank: true, nullable: true, attributes: [title: 'longitud'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [title: 'estado'])
        referencia(size: 1..127, blank: true, nullable: true, attributes: [title: 'referencia'])
        fechaCreacion(blank: true, nullable: true, attributes: [title: 'fecha'])
        oficioIngreso(size: 1..15, blank: true, nullable: true, attributes: [title: 'oficioIngreso'])
        oficioSalida(size: 1..15, blank: true, nullable: true, attributes: [title: 'oficioSalida'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
        fechaPrecios(blank: true, nullable: true, attributes: [title: 'fecha'])
        memoCantidadObra(size: 1..15, blank: true, nullable: true, attributes: [title: 'memoCantidadObra'])
        memoSalida(size: 1..15, blank: true, nullable: true, attributes: [title: 'memoSalida'])
        fechaOficioSalida(blank: true, nullable: true, attributes: [title: 'fechaOficioSalida'])
        sitio(size: 1..63, blank: true, nullable: true, attributes: [title: 'sitio'])
        valor(blank: true, nullable: true, attributes: [title: 'valor'])
        memoCertificacionPartida(size: 1..31, blank: true, nullable: true, attributes: [title: 'memoCertificacionPartida'])
        memoActualizacionPrefecto(size: 1..31, blank: true, nullable: true, attributes: [title: 'memoActualizacionPrefecto'])
        memoPartidaPresupuestaria(size: 1..31, blank: true, nullable: true, attributes: [title: 'memoPartidaPresupuestaria'])
        porcentajeAnticipo(blank: true, nullable: true, attributes: [title: 'porcentajeAnticipo'])
        origen(size: 1..511,  blank: true, nullable: true, attributes: [title: 'origen'])
        caracteristicasTecnicas(size: 1..511, blank: true, nullable: true, attributes: [title: 'caracteristicasTecnicas'])
        distancia(blank: true, nullable: true)
        sitioEntrega(size: 1..63, blank: true, nullable: true, attributes: [title: 'sitioEntrega'])
    }
}
