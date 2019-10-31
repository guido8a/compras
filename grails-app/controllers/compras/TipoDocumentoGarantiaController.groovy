package compras

class TipoDocumentoGarantiaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def form_ajax () {
        def  tipoDocGarantiaInstance = new TipoDocumentoGarantia(params)
        if (params.id) {
            tipoDocGarantiaInstance = TipoDocumentoGarantia.get(params.id)
            if (!tipoDocGarantiaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Tipo de Documento de Garantía"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoDocGarantiaInstance: tipoDocGarantiaInstance]
    }

    def tablaTipoDocGarantia () {
        def tipoDocGarantias= TipoDocumentoGarantia.list().sort{it.descripcion}
        return[lista: tipoDocGarantias]
    }

    def borrarTipoDocGarantia_ajax (){
        def tipoDocGarantia = TipoDocumentoGarantia.get(params.id)

        try{
            tipoDocGarantia.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de documento de garantía " + e)
            render "no"
        }
    }

    def save () {
        def tipoDocGarantiaInstance

        params.descripcion = params.descripcion.toUpperCase()

        if(params.id) {
            tipoDocGarantiaInstance = TipoDocumentoGarantia.get(params.id)
        }//es edit
        else {
            tipoDocGarantiaInstance = new TipoDocumentoGarantia()
        } //es create

        tipoDocGarantiaInstance.properties = params

        if (!tipoDocGarantiaInstance.save(flush: true)) {
            render "no_Error al guardar el tipo de documento de garantía"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de documento de garantía"
            } else {
                render "ok_Se ha creado correctamente el tipo de documento de garantía"
            }
        }
    }

}
