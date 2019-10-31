package compras

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ValoresAnualesController {



    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list () {

    }

    def tablaValoresAnuales () {
        def valores = ValoresAnuales.list().sort{it.anio.anio}
        return [lista: valores]
    }

    def form_ajax () {

        def valoresInstance = new ValoresAnuales(params)
        if (params.id) {
            valoresInstance = ValoresAnuales.get(params.id)
            if (!valoresInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Valores anuales"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [valoresInstance: valoresInstance]
    }

    def save () {

        println("params " + params)

        def valoresInstance

        if(params.id) {
            valoresInstance = ValoresAnuales.get(params.id)

            if(valoresInstance.anio.id != params.anio.toInteger()){
             if(comprobarAnio(params.anio)){
                 render "er_El año seleccionado ya contiene valores anuales"
                 return
             }else{
                 valoresInstance.properties = params
             }
            }else{
                valoresInstance.properties = params
            }

        }else{
            valoresInstance = new ValoresAnuales()

            if(comprobarAnio(params.anio)){
                render "er_El año seleccionado ya contiene valores anuales"
                return
            }else{
                valoresInstance.properties = params
            }
        }

        if(!valoresInstance.save(flush: true)){
            println("error al guardar los valores anuales " + valoresInstance.errors)
            render "no_Error al guardar los valores anuales"
        }else{
            render "ok_Valores anuales guardados correctamente"
        }
    }



    def comprobarAnio(anio) {
        def an = Anio.get(anio)
        def existentes = ValoresAnuales.findAllByAnio(an)

        if(existentes){
            return true
        }else{
            return false
        }
    }

    def borrarValores_ajax () {

        def valor = ValoresAnuales.get(params.id)

        try{
            valor.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el valor anual " + e)
            render "no"
        }
    }

}
