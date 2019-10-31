package compras


class EstadoGarantiaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def form_ajax () {
        def  estadoGarantiaInstance = new EstadoGarantia(params)
        if (params.id) {
            estadoGarantiaInstance = EstadoGarantia.get(params.id)
            if (!estadoGarantiaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Estado de Garantía"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [estadoGarantiaInstance: estadoGarantiaInstance]
    }

    def tablaEstadoGarantia () {
        def estadoGarantias= EstadoGarantia.list().sort{it.descripcion}
        return[lista: estadoGarantias]
    }

    def borrarEstadoGarantia_ajax (){
        def estadoGarantia = EstadoGarantia.get(params.id)

        try{
            estadoGarantia.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el estado de garantía " + e)
            render "no"
        }
    }

    def save () {
        def estadoGarantiaInstance

        if(params.id) {
            estadoGarantiaInstance = EstadoGarantia.get(params.id)
        }//es edit
        else {
            estadoGarantiaInstance = new EstadoGarantia()
        } //es create

        estadoGarantiaInstance.properties = params

        if (!estadoGarantiaInstance.save(flush: true)) {
            render "no_Error al guardar el estado de garantía"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el estado de garantía"
            } else {
                render "ok_Se ha creado correctamente el estado de garantía"
            }
        }
    }

}
