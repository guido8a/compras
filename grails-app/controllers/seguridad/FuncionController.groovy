package seguridad

class FuncionController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond funcionService.list(params), model:[funcionCount: funcionService.count()]
    }

    def list () {

    }

    def form_ajax () {
        def  funcionInstance = new Funcion(params)
        if (params.id) {
            funcionInstance = Funcion.get(params.id)
            if (!funcionInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la Función"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [funcionInstance: funcionInstance]
    }

    def tablaFuncion () {
        def funciones = Funcion.list().sort{it.descripcion}
        return[lista: funciones]
    }

    def borrarFuncion_ajax (){
        def funcion = Funcion.get(params.id)

        try{
            funcion.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la función " + e)
            render "no"
        }
    }

    def save () {

        println("params sf " + params)

        def funcionInstance

        params.descripcion = params.descripcion.toUpperCase()
        params.codigo = params.codigo.toUpperCase()

        if(params.id) {
            funcionInstance = Funcion.get(params.id)
            if(!funcionInstance) {
                render "no_No se encontró la unidad"
                return
            }//no existe el objeto

            if(funcionInstance?.codigo == params.codigo){
                funcionInstance.properties = params
            }else{
                if(Funcion.findAllByCodigo(params.codigo)){
                    render "no_Ya existe una unidad registrada con este código!"
                    return
                }else{
                    funcionInstance.properties = params
                }
            }
        }//es edit
        else {
            if(Funcion.findAllByCodigo(params.codigo)){
                render "no_Ya existe una unidad registrada con este código!"
                return
            }else{
                funcionInstance = new Funcion(params)
            }
        } //es create
        if (!funcionInstance.save(flush: true)) {
            println("error " + funcionInstance.errors)
            render "no_Error al guardar la unidad"
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la unidad "
            } else {
                render "ok_Se ha creado correctamente la unidad "
            }
        }
    }

}
