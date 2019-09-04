package compras

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ProgramacionController {
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def list () {

    }

    def tablaProgramacion () {

        def programacion = Programacion.list().sort{it.descripcion}
        return [lista: programacion]
    }

    def form_ajax () {

        def programacionInstance = new Programacion(params)
        if (params.id) {
            programacionInstance = Programacion.get(params.id)
            if (!programacionInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la programación"
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [programacionInstance: programacionInstance]
    }

    def save () {

//        println("params sp " + params)

        def fechaInicio
        def fechaFin

        if(params.fechaInicio){
            fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
            params.fechaInicio = fechaInicio
        }

        if(params.fechaFin){
            fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
            params.fechaFin = fechaFin
        }

        def programacionInstance

        if(params.id) {
            programacionInstance = Programacion.get(params.id)

            if(!programacionInstance) {
                render "no_No se encontró la programación"
                return
            }//no existe el objeto
            programacionInstance.properties = params
        }//es edit
        else {
            programacionInstance = new Programacion(params)
        } //es create
        if (!programacionInstance.save(flush: true)) {
            println("error: " + programacionInstance?.errors)
            render "no_Error al guardar la programación"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la programación "
            } else {
                render "ok_Se ha creado correctamente la programación "
            }
        }
    }


    def borrarProgramacion_ajax () {

        def programacion = Programacion.get(params.id)

        try{
            programacion.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la programacion " + e)
            render "no"
        }
    }


}
