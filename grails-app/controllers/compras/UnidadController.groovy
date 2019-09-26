package compras


class UnidadController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond unidadService.list(params), model:[unidadCount: unidadService.count()]
    }


    def list () {

    }

    def form_ajax () {
        def  unidadInstance = new Unidad(params)
        if (params.id) {
            unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la Unidad"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [unidadInstance: unidadInstance]
    }

    def tablaUnidad () {
        def unidades = Unidad.list().sort{it.descripcion}
        return[lista: unidades]
    }

    def borrarUnidad_ajax (){
        def unidad = Unidad.get(params.id)

        try{
            unidad.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la unidad " + e)
            render "no"
        }
    }


    def save () {
        def unidadInstance

        params.descripcion = params.descripcion.toUpperCase()

        if(params.id) {
            unidadInstance = Unidad.get(params.id)
            if(!unidadInstance) {
                render "no_No se encontró la unidad"
                return
            }//no existe el objeto

            if(unidadInstance?.codigo == params.codigo){
                unidadInstance.properties = params
            }else{
                if(Unidad.findAllByCodigo(params.codigo)){
                    render "no_Ya existe una unidad registrada con este código!"
                    return
                }else{
                    unidadInstance.properties = params
                }
            }
        }//es edit
        else {
            if(Unidad.findAllByCodigo(params.codigo)){
                render "no_Ya existe una unidad registrada con este código!"
                return
            }else{
                unidadInstance = new Unidad(params)
            }
        } //es create
        if (!unidadInstance.save(flush: true)) {
            render "no_Error al guardar la unidad"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la unidad "
            } else {
                render "ok_Se ha creado correctamente la unidad "
            }
        }
    }

}
