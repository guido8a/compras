package compras

import org.springframework.dao.DataIntegrityViolationException

class TipoObraController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond tipoObraService.list(params), model:[tipoObraCount: tipoObraService.count()]
    }

    def list () {

    }

    def form_ajax () {
        def  tipoObraInstance = new TipoObra(params)
        if (params.id) {
            tipoObraInstance = TipoObra.get(params.id)
            if (!tipoObraInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el Tipo de Obra"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoObraInstance: tipoObraInstance]
    }

    def tablaTipoObra () {
        def tipoObras = TipoObra.list().sort{it.descripcion}
        return[lista: tipoObras]
    }

    def borrarTipoObra_ajax (){
        def tipoObra = TipoObra.get(params.id)

        try{
            tipoObra.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de obra " + e)
            render "no"
        }
    }


    def save () {
        def tipoObraInstance

        params.codigo = params.codigo.toUpperCase()

        if(params.id) {
            tipoObraInstance = TipoObra.get(params.id)
            if(!tipoObraInstance) {
                render "no_No se encontró el Tipo de Obra"
                return
            }//no existe el objeto


           if(revisarCodigo(params.codigo,tipoObraInstance )){
               render "no_Ya existe un tipo de obra registrada con este código!"
               return
           }else{
               if(revisarDescripcion(params.descripcion,tipoObraInstance )){
                   render "no_Ya existe un tipo de obra registrada con esta descripción!"
                   return
               }else{
                   tipoObraInstance.properties = params
               }
           }
        }//es edit
        else {
            if(TipoObra.findAllByCodigo(params.codigo)){
                render "no_Ya existe una tipo de obra registrada con este código!"
                return
            }else{
                if(TipoObra.findAllByDescripcionIlike(params.descripcion?.trim())){
                    render "no_Ya existe un tipo de obra registrada con esta descripción!"
                    return
                }else{
                    tipoObraInstance = new TipoObra(params)
                }
            }
        } //es create

        if (!tipoObraInstance.save(flush: true)) {
            render "no_Error al guardar el tipo de obra"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el tipo de obra"
            } else {
                render "ok_Se ha creado correctamente el tipo de obra"
            }
        }
    }


    def revisarCodigo(codigo, tipoObraInstance) {

        if(tipoObraInstance?.codigo == codigo){
            return false
        }else{
            if(TipoObra.findAllByCodigo(codigo)){
                return true
            }else{
                return false
            }
        }
    }


    def revisarDescripcion(descripcion, tipoObraInstance) {

        if(tipoObraInstance?.descripcion?.toUpperCase() == descripcion?.toUpperCase()){
            return false
        }else{
            if(TipoObra.findAllByDescripcionIlike(descripcion)){
                return true
            }else{
                return false
            }
        }
    }


}
