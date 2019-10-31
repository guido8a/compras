package compras


class TipoGarantiaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def form_ajax () {
        def  tipoGarantiaInstance = new TipoGarantia(params)
        if (params.id) {
            tipoGarantiaInstance = TipoGarantia.get(params.id)
            if (!tipoGarantiaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Tipo de Garantía"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoGarantiaInstance: tipoGarantiaInstance]
    }

    def tablaTipoGarantia () {
        def tipoGarantias= TipoGarantia.list().sort{it.descripcion}
        return[lista: tipoGarantias]
    }

    def borrarTipoGarantia_ajax (){
        def tipoGarantia = TipoGarantia.get(params.id)

        try{
            tipoGarantia.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de garantía " + e)
            render "no"
        }
    }

    def save () {
        def tipoGarantiaInstance

        if(params.id) {
            tipoGarantiaInstance = TipoGarantia.get(params.id)
        }//es edit
        else {
            tipoGarantiaInstance = new TipoGarantia()
        } //es create

        tipoGarantiaInstance.properties = params

        if (!tipoGarantiaInstance.save(flush: true)) {
            render "no_Error al guardar el tipo de garantía"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de garantía"
            } else {
                render "ok_Se ha creado correctamente el tipo de garantía"
            }
        }
    }



//    def revisarDescripcion(descripcion, tipoGarantiaInstance) {
//
//        if(tipoGarantiaInstance?.descripcion?.toUpperCase() == descripcion?.toUpperCase()?.trim()){
//            return false
//        }else{
//            if(TipoGarantia.findAllByDescripcionIlike(descripcion)){
//                return true
//            }else{
//                return false
//            }
//        }
//    }

}
