package compras


class AdministracionController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond administracionService.list(params), model:[administracionCount: administracionService.count()]
    }

    def list () {
    }

    def tablaAdministracion () {
        def administraciones = Administracion.list().sort{it.fechaInicio}
        return[lista: administraciones]
    }

    def form_ajax () {
        def  administracionInstance = new Administracion(params)
        if (params.id) {
            administracionInstance = Administracion.get(params.id)
            if (!administracionInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró adminstración"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [administracionInstance: administracionInstance]
    }

    def borrarAdministracion_ajax (){
        def admnistracion = Administracion.get(params.id)

        try{
            admnistracion.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la administracion " + e)
            render "no"
        }
    }

    def save () {

//        println("params sa " + params)

        params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)

        def administracionInstance

        if(params.id) {
            administracionInstance = Administracion.get(params.id)
            if(!administracionInstance) {
                render "no_No se encontró la administración"
                return
            }//no existe el objeto
        }//es edit
        else {
            administracionInstance = new Administracion(params)
        } //es create

        administracionInstance.properties = params

        if (!administracionInstance.save(flush: true)) {
            render "no_Error al guardar la administración"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la administración "
            } else {
                render "ok_Se ha creado correctamente la administración"
            }
        }
    }


}
