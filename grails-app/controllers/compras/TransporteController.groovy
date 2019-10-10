package compras

class TransporteController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond transporteService.list(params), model: [transporteCount: transporteService.count()]
    }


    def list () {

    }

    def form_ajax () {
        def  transporteInstance = new Transporte(params)
        if (params.id) {
            transporteInstance = Transporte.get(params.id)
            if (!transporteInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró transporte"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [transporteInstance: transporteInstance]
    }

    def tablaTransporte() {
        def transportes = Transporte.list().sort{it.descripcion}
        return[lista: transportes]
    }

    def borrarTransporte_ajax (){
        def transporte = Transporte.get(params.id)

        try{
            transporte.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el transporte " + e)
            render "no"
        }
    }

    def save () {
        def transporteInstance

        params.descripcion = params.descripcion.toUpperCase()

        if(params.id) {
            transporteInstance = Transporte.get(params.id)
            if(!transporteInstance) {
                render "no_No se encontró transporte"
                return
            }//no existe el objeto

            if(transporteInstance?.codigo == params.codigo){
                transporteInstance.properties = params
            }else{
                if(Transporte.findAllByCodigo(params.codigo)){
                    render "no_Ya existe una tipo de transporte registrado con este código!"
                    return
                }else{
                    transporteInstance.properties = params
                }
            }
        }//es edit
        else {
            if(Unidad.findAllByCodigo(params.codigo)){
                render "no_Ya existe un transporte registrado con este código!"
                return
            }else{
                transporteInstance = new Transporte(params)
            }
        } //es create
        if (!transporteInstance.save(flush: true)) {
            render "no_Error al guardar el transporte"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el transporte "
            } else {
                render "ok_Se ha creado correctamente el transporte "
            }
        }
    }

}