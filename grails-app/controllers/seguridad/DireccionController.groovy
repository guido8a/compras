package seguridad

import seguridad.Direccion

class DireccionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond direccionService.list(params), model:[direccionCount: direccionService.count()]
    }
    def list () {

    }

    def form_ajax () {
        def  direccionInstance = new Direccion(params)
        if (params.id) {
            direccionInstance = Direccion.get(params.id)
            if (!direccionInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la dirección"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [direccionInstance: direccionInstance]
    }

    def tablaDireccion() {
        def direcciones = Direccion.list().sort{it.nombre}
        return[lista: direcciones]
    }

    def borrarDireccion_ajax (){
        def direccion = Direccion.get(params.id)

        try{
            direccion.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la dirección " + e)
            render "no"
        }
    }

    def save () {
        def direccionInstance

        params.nombre = params.nombre.toUpperCase()

        if(params.id) {
            direccionInstance = Direccion.get(params.id)
            if(!direccionInstance) {
                render "no_No se encontró la dirección"
                return
            }//no existe el objeto
        }//es edit
        else {
            direccionInstance = new Direccion(params)
        } //es create

        direccionInstance.properties = params

        if (!direccionInstance.save(flush: true)) {
            render "no_Error al guardar la dirección"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la dirección "
            } else {
                render "ok_Se ha creado correctamente la dirección"
            }
        }
    }

}
