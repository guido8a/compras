package compras


class AseguradoraController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def form_ajax () {
        def  aseguradoraInstance = new Aseguradora(params)
        if (params.id) {
            aseguradoraInstance = Aseguradora.get(params.id)
            if (!aseguradoraInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la Aseguradora"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [aseguradoraInstance: aseguradoraInstance]
    }

    def tablaAseguradora () {
        def aseguradora = Aseguradora.list().sort{it.nombre}
        return[lista: aseguradora]
    }

    def borrarAseguradora_ajax (){
        def aseguradora = Aseguradora.get(params.id)

        try{
            aseguradora.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la aseguradora " + e)
            render "no"
        }
    }

    def save () {
        def aseguradoraInstance

        if(params.id) {
            aseguradoraInstance = Aseguradora.get(params.id)
            if(!aseguradoraInstance) {
                render "no_No se encontró la aseguradora"
                return
            }//no existe el objeto
        }//es edit
        else {
            aseguradoraInstance = new Aseguradora()
        } //es create

        aseguradoraInstance.properties = params

        if (!aseguradoraInstance.save(flush: true)) {
            render "no_Error al guardar la aseguradora"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la aseguradora "
            } else {
                render "ok_Se ha creado correctamente la aseguradora "
            }
        }
    }
}
