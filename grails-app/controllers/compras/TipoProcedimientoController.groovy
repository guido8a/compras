package compras


class TipoProcedimientoController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def form_ajax () {
        def  tipoProcedimientoInstance = new TipoProcedimiento(params)
        if (params.id) {
            tipoProcedimientoInstance = TipoProcedimiento.get(params.id)
            if (!tipoProcedimientoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la Aseguradora"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoProcedimientoInstance: tipoProcedimientoInstance]
    }

    def tablaTipoProcedimiento () {
        def tipoProcedimiento = TipoProcedimiento.list().sort{it.descripcion}
        return[lista: tipoProcedimiento]
    }

    def borrarTipoProcedimiento_ajax (){
        def tipoProcedimiento = TipoProcedimiento.get(params.id)

        try{
            tipoProcedimiento.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de procedimiento " + e)
            render "no"
        }
    }

    def save () {
        def tipoProcedimientoInstance

        if(params.id) {
            tipoProcedimientoInstance = TipoProcedimiento.get(params.id)
            if(!tipoProcedimientoInstance) {
                render "no_No se encontró el tipo de procedimiento"
                return
            }//no existe el objeto
        }//es edit
        else {
            tipoProcedimientoInstance = new TipoProcedimiento()
        } //es create

        tipoProcedimientoInstance.properties = params

        if (!tipoProcedimientoInstance.save(flush: true)) {
            println("error al guardar el procedimiento " + tipoProcedimientoInstance.errors)
            render "no_Error al guardar el tipo de procedimiento"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de procedimiento "
            } else {
                render "ok_Se ha creado correctamente el tipo de procedimiento"
            }
        }
    }

}
