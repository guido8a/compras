package compras


class CriterioController {

    def list () {

    }

    def form_ajax () {
        def  criterioInstance = new Criterio(params)
        if (params.id) {
            criterioInstance = Criterio.get(params.id)
            if (!criterioInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Criterio"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [criterioInstance: criterioInstance]
    }

    def tablaCriterio () {
        def criterio = Criterio.list().sort{it.descripcion}
        return[lista: criterio]
    }

    def borrarCriterio_ajax (){
        def criterio = Criterio.get(params.id)

        try{
            criterio.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el criterio " + e)
            render "no"
        }
    }

    def save () {
        def criterioInstance

        if(params.id) {
            criterioInstance = Criterio.get(params.id)
            if(!criterioInstance) {
                render "no_No se encontró el criterio"
                return
            }//no existe el objeto
        }//es edit
        else {
            criterioInstance = new Criterio()
        } //es create

        criterioInstance.properties = params

        if (!criterioInstance.save(flush: true)) {
            println("error  al guardar el criterio " + criterioInstance.errors)
            render "no_Error al guardar el criterio"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el criterio"
            } else {
                render "ok_Se ha creado correctamente el criterio"
            }
        }
    }


}
