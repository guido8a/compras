package compras


import org.springframework.dao.DataIntegrityViolationException

class AnioController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
    } //list

    def form_ajax() {
        def anioInstance = new Anio(params)
        if (params.id) {
            anioInstance = Anio.get(params.id)
            if (!anioInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Anio con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [anioInstance: anioInstance]
    } //form_ajax

    def save() {

//        println("params sa " +  params)

        def existeAnio = Anio.findByAnio(params.anio)

        if(!existeAnio){

            def anio = new Anio()
            anio.anio = params.anio
            anio.estado = 0

            if(!anio.save(flush: true)){
                render "ok"
            }else{
                render "no"
            }

        }else{
            render "er_Ya existe creado el año ${params.anio}!"
        }
    } //save

    def tablaAnio () {
        def anios = Anio.list().sort{it.anio}
        return[lista: anios]
    }

    def borrarAnio_ajax (){
        def anio = Anio.get(params.id)

        def diasLaborables = DiaLaborable.findAllByAnio(anio)


        if(diasLaborables){
            render "er_No se puede borrar el Año, se encuentra en uso."
        }else{
            try{
                anio.delete(flush: true)
                render "ok"
            }catch(e){
                println("error al borrar el anio " + e)
                render "no"
            }
        }

    }

} //fin controller
