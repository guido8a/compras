package compras


class TipoAseguradoraController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def form_ajax () {
        def  tipoAseguradoraInstance = new TipoAseguradora(params)
        if (params.id) {
            tipoAseguradoraInstance = TipoAseguradora.get(params.id)
            if (!tipoAseguradoraInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Tipo de Aseguradora"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoAseguradoraInstance: tipoAseguradoraInstance]
    }

    def tablaTipoAseguradora () {
        def tipoAsegurado= TipoAseguradora.list().sort{it.descripcion}
        return[lista: tipoAsegurado]
    }

    def borrarTipoAseguradora_ajax (){
        def tipoAseguradora = TipoAseguradora.get(params.id)

        try{
            tipoAseguradora.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de aseguradora " + e)
            render "no"
        }
    }

    def save () {
        def tipoAseguradoraInstance

        params.codigo = params.codigo.toUpperCase()?.trim()

        if(params.id) {
            tipoAseguradoraInstance = TipoAseguradora.get(params.id)
            if(!tipoAseguradoraInstance) {
                render "no_No se encontró el tipo de aseguradora"
                return
            }//no existe el objeto

            if(tipoAseguradoraInstance?.codigo == params.codigo){
                tipoAseguradoraInstance.properties = params
            }else{
                if(TipoAseguradora.findAllByCodigo(params.codigo)){
                    render "no_Ya existe un tipo de aseguradora registrada con este código!"
                    return
                }else{
                    tipoAseguradoraInstance.properties = params
                }
            }
        }//es edit
        else {
            if(TipoAseguradora.findAllByCodigo(params.codigo)){
                render "no_Ya existe un tipo de aseguradora registrada con este código!"
                return
            }else{
                tipoAseguradoraInstance = new TipoAseguradora(params)
            }
        } //es create
        if (!tipoAseguradoraInstance.save(flush: true)) {
            render "no_Error al guardar el tipo de aseguradora"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de aseguradora "
            } else {
                render "ok_Se ha creado correctamente el tipo de aseguradora "
            }
        }
    }

}
