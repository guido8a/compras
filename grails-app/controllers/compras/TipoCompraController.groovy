package compras


class TipoCompraController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list() {

    }

    def form_ajax () {
        def  tipoCompraInstance = new TipoCompra(params)
        if (params.id) {
            tipoCompraInstance = TipoCompra.get(params.id)
            if (!tipoCompraInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el tipo de compra"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoCompraInstance: tipoCompraInstance]
    }

    def tablaTipoCompra () {
        def tipos = TipoCompra.list().sort{it.descripcion}
        return[lista: tipos]
    }

    def borrarTipoCompra_ajax (){
        def tipo = TipoCompra.get(params.id)

        try{
            tipo.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de compra " + e)
            render "no"
        }
    }

    def save () {
        def tipoCompraInstance

        if(params.id) {
            tipoCompraInstance = TipoCompra.get(params.id)
        }//es edit
        else {
            tipoCompraInstance = new TipoCompra()
        } //es create

        tipoCompraInstance.properties = params

        if (!tipoCompraInstance.save(flush: true)) {
            render "no_Error al guardar el tipo de compra"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de compra"
            } else {
                render "ok_Se ha creado correctamente el tipo de compra"
            }
        }
    }


}
