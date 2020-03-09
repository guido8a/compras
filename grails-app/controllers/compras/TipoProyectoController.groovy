package compras


class TipoProyectoController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def list () {

    }

    def form_ajax () {
        def  tipoProyectoInstance = new TipoProyecto(params)
        if (params.id) {
            tipoProyectoInstance = TipoProyecto.get(params.id)
            if (!tipoProyectoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Tipo de Proyecto"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoProyectoInstance: tipoProyectoInstance]
    }

    def tablaTipoProyecto () {
        def proyectos = TipoProyecto.list().sort{it.descripcion}
        return[lista: proyectos]
    }

    def borrarTipoProyecto_ajax (){
        def tipoProyecto = TipoProyecto.get(params.id)

        try{
            tipoProyecto.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de proyecto " + e)
            render "no"
        }
    }

    def save () {

        def tipoProyectoInstance

        if(params.id) {
            tipoProyectoInstance = TipoProyecto.get(params.id)
        }//es edit
        else {
            tipoProyectoInstance = new TipoProyecto()
        } //es create

        tipoProyectoInstance.properties = params

        if (!tipoProyectoInstance.save(flush: true)) {
            println("error al guardar tppy " + tipoProyectoInstance?.errors)
            render "no_Error al guardar el tipo de proyecto"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de proyecto"
            } else {
                render "ok_Se ha creado correctamente el tipo de proyecto"
            }
        }
    }

}
