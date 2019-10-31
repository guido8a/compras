package compras

class ProveedorController {

    def dbConnectionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def buscarProveedor () {

    }

    def tablaProveedor() {

//        println("params tp" + params)

        def cn = dbConnectionService.getConnection()
        def sql

        if(params.canton){
            sql = "select * from prve where prvenmbr ilike '%${params.nombre}%' and prve_ruc ilike '%${params.ruc}%' and cntn__id = '${params.canton}'"
        }else{
            sql = "select * from prve where prvenmbr ilike '%${params.nombre}%' and prve_ruc ilike '%${params.ruc}%' order by cntn__id asc"
        }

//        println "sql: $sql"

        def data = cn.rows(sql.toString())

//        println("data " + data)

        return [data:data]
    }

    def form_ajax () {
        def  proveedorInstance = new Proveedor(params)
        if (params.id) {
            proveedorInstance = Proveedor.get(params.id)
            if (!proveedorInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el proveedor"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [proveedorInstance: proveedorInstance]
    }

    def canton_ajax () {
        def provincia = Provincia.get(params.provincia)
        def cantones = Canton.findAllByProvincia(provincia)
        def canton
        if(params.id){
            canton = Proveedor.get(params.id).canton.id
        }

        return[cantones: cantones, canton: canton]
    }

    def save () {

//        println("params " + params)

        def proveedor

        params.ruc = params.ruc.trim()

        if(params.id){
            proveedor = Proveedor.get(params.id)

            if(proveedor.ruc == params.ruc){
                proveedor.properties = params
            }else{
                if(Proveedor.findAllByRuc(params.ruc)){
                    render "no_Ya existe un proveedor con ese RUC"
                    return
                }else{
                    proveedor.properties = params
                }
            }
        }else{
            proveedor = new Proveedor()
            if(Proveedor.findAllByRuc(params.ruc)){
                render "no_Ya existe un proveedor con ese RUC"
                return
            }else{
                proveedor.properties = params
            }
        }

        if(!proveedor.save(flush: true)){
            println("error al guardar proveedor " + proveedor.errors)
            render "no_Error al guardar el proveedor"
        }else{
            render "ok_Proveedor guardado correctamente"
        }
    }


    def borrarProveedor_ajax (){

        def proveedor = Proveedor.get(params.id)

        try{
            proveedor.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el proveedor " + e + " " + proveedor.error)
            render "no"
        }
    }

}
