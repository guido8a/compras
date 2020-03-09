package compras


class ProformaController {

    def dbConnectionService

    def proforma () {
//        println("params " + params)

        def proforma

        if(params.id){
            proforma = Proforma.get(params.id)
        }else{
            proforma = new Proforma()
        }
        if(params.tipo == '1'){
            def proyecto = Proyecto.get(params.proyecto)
            return[proforma: proforma, proyecto: proyecto, tipo: 1]
        }else{
            return[proforma: proforma, tipo: 0]
        }
    }

    def guardarProforma_ajax () {

//        println("params gpr " + params)

        def proforma
        def fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        def estado

        if(params.id){
            proforma = Proforma.get(params.id)
            estado = proforma.estado
        }else{
            proforma = new Proforma()
            estado = 'N'
        }

        params.estado = estado
        params.fecha = fecha
        proforma.properties = params

        if(!proforma.save(flush: true)){
            println("error al guardar la proforma " + proforma.errors)
            render "no"
        }else{
            render "ok_" + proforma?.id
        }
    }

    def cambiarEstado_ajax () {
        def proforma = Proforma.get(params.id)

        if(proforma.estado == 'N'){
            proforma.estado = 'R'
        }else{
            proforma.estado = 'N'
        }

        if(!proforma.save(flush:true)){
            render "no"
        }else{
            render "ok"
        }
    }

    def list () {
        def proyecto = Proyecto.get(params.proyecto)
        return[proyecto: proyecto]
    }

    def tablaProforma() {
//        println("params tp " + params)

        def proyecto = Proyecto.get(params.proyecto)

        def cn = dbConnectionService.getConnection()
        def sql

        if(params.proveedor){
            sql = "select  prfr__id, prvenmbr, prfrdscr, prfrfcen, prfrobsr from prfr, " +
                    "prve where prve.prve__id = prfr.prve__id and prfrdscr ilike '%${params.descripcion}%' and prve.prve__id = '${params.proveedor}' and prfrfcen >= '${params.fecha}'"
        }else{
            sql = "select prfr__id, prvenmbr, prfrdscr, prfrfcen, prfrobsr from prfr, " +
                    "prve where prve.prve__id = prfr.prve__id and prfrdscr ilike '%${params.descripcion}%' and prfrfcen >= '${params.fecha}' order by prvenmbr asc"
        }

//        println "sql: $sql"

        def data = cn.rows(sql.toString())

//        println("data " + data)

        return [lista:data, proyecto: proyecto]
    }

    def borrarProforma_ajax () {

        def proforma = Proforma.get(params.id)
        def detallesExistentes = DetalleProforma.findAllByProforma(proforma)

        if(detallesExistentes.size() > 0){
            render "er_No se puede borrar, existen items asociados a esta proforma"
        }else{
            try{
                proforma.delete(flush: true)
                render "ok"
            }catch(e){
                println("error al borrar la proforma " + e + proforma.errors)
                render "no"
            }
        }
    }

}
