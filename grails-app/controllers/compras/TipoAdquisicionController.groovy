package compras

class TipoAdquisicionController {



    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]



    def list () {

    }

    def tablaAdquisicion () {

        def adquisiciones = TipoAdquisicion.list().sort{it.descripcion}
        return [lista: adquisiciones]
    }

    def form_ajax () {

        def tipoAdquisicionInstance = new TipoAdquisicion(params)
        if (params.id) {
            tipoAdquisicionInstance = TipoAdquisicion.get(params.id)
            if (!tipoAdquisicionInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Tipo de Adquisicion"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoAdquisicionInstance: tipoAdquisicionInstance]
    }

    def save () {

        def tipoAdquisicionInstance

        if(params.id) {
            tipoAdquisicionInstance = TipoAdquisicion.get(params.id)
            if(!tipoAdquisicionInstance) {
                render "no_No se encontró el Tipo de Adquisición"
                return
            }//no existe el objeto

            if(tipoAdquisicionInstance?.codigo == params.codigo){
                tipoAdquisicionInstance.properties = params
            }else{
                if(TipoAdquisicion.findAllByCodigo(params.codigo)){
                    render "no_Ya existe un tipo de adquisición registrado con este código!"
                    return
                }else{
                    tipoAdquisicionInstance.properties = params
                }
            }
        }//es edit
        else {
            if(TipoAdquisicion.findAllByCodigo(params.codigo)){
                render "no_Ya existe un tipo de adquisición registrado con este código!"
                return
            }else{
                tipoAdquisicionInstance = new TipoAdquisicion(params)
            }
        } //es create
        if (!tipoAdquisicionInstance.save(flush: true)) {
            render "no_Error al guardar el tipo de adquisicion"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de Adquisición "
            } else {
                render "ok_Se ha creado correctamente el tipo de Adquisición "
            }
        }
    }

    def borrarTipoAdquisicion_ajax () {

        def tipo = TipoAdquisicion.get(params.id)

        try{
            tipo.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de adquisicion " + e)
            render "no"
        }
    }



}
