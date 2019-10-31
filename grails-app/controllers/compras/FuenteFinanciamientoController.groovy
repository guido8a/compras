package compras


class FuenteFinanciamientoController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def form_ajax () {
        def  fuenteFinanciamientoInstance = new FuenteFinanciamiento(params)
        if (params.id) {
            fuenteFinanciamientoInstance = FuenteFinanciamiento.get(params.id)
            if (!fuenteFinanciamientoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la fuente de financiamiento"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [fuenteFinanciamientoInstance: fuenteFinanciamientoInstance]
    }

    def tablaFuenteFinanciamiento () {
        def fuentes = FuenteFinanciamiento.list().sort{it.descripcion}
        return[lista: fuentes]
    }

    def borrarFuenteFinanciamiento_ajax (){
        def fuente = FuenteFinanciamiento.get(params.id)

        try{
            fuente.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la fuente de financiamiento " + e)
            render "no"
        }
    }

    def save () {
        def fuenteFinanciamientoInstance

        if(params.id) {
            fuenteFinanciamientoInstance = FuenteFinanciamiento.get(params.id)
        }//es edit
        else {
            fuenteFinanciamientoInstance = new FuenteFinanciamiento()
        } //es create

        fuenteFinanciamientoInstance.properties = params

        if (!fuenteFinanciamientoInstance.save(flush: true)) {
            render "no_Error al guardar la fuente de financiamiento"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la fuente de financiamiento"
            } else {
                render "ok_Se ha creado correctamente la fuente de financiamiento"
            }
        }
    }

}
