package compras


class TipoListaController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond tipoListaService.list(params), model:[tipoListaCount: tipoListaService.count()]
    }

    def list () {

    }

    def form_ajax () {
        def  tipoListaInstance = new TipoLista(params)
        if (params.id) {
            tipoListaInstance = TipoLista.get(params.id)
            if (!tipoListaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Tipo de Lista"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoListaInstance: tipoListaInstance]
    }

    def tablaTipoLista () {
        def lista = TipoLista.list().sort{it.descripcion}
        return [lista: lista]
    }

    def borrarTipoLista_ajax (){
        def lista = TipoLista.get(params.id)

        try{
            lista.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de lista " + e)
            render "no"
        }
    }

    def save () {
        def tipoListaInstance

        params.codigo = params.codigo.toUpperCase();

        if(params.id) {
            tipoListaInstance = TipoLista.get(params.id)
            if(!tipoListaInstance) {
                render "no_No se encontró el tipo de lista"
                return
            }//no existe el objeto

            if(tipoListaInstance?.codigo == params.codigo){
                tipoListaInstance.properties = params
            }else{
                if(TipoLista.findAllByCodigo(params.codigo)){
                    render "no_Ya existe un tipo de lista registrado con este código!"
                    return
                }else{
                    tipoListaInstance.properties = params
                }
            }
        }//es edit
        else {
            if(TipoLista.findAllByCodigo(params.codigo)){
                render "no_Ya existe un tipo de lista registrado con este código!"
                return
            }else{
                tipoListaInstance = new TipoLista(params)
            }
        } //es create
        if (!tipoListaInstance.save(flush: true)) {
            render "no_Error al guardar el tipo de lista"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de lista "
            } else {
                render "ok_Se ha creado correctamente el tipo de lista "
            }
        }
    }


}
