package compras

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

import org.springframework.dao.DataIntegrityViolationException

class ComunidadController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [comunidadInstanceList: Comunidad.list(params), comunidadInstanceTotal: Comunidad.count(), params: params]
    } //list

    def form_ajax() {
        def comunidadInstance = new Comunidad(params)
        if (params.id) {
            comunidadInstance = Comunidad.get(params.id)
            if (!comunidadInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Comunidad con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [comunidadInstance: comunidadInstance, padre: params.padre ?: comunidadInstance?.parroquia?.id]
    } //form_ajax

    def save() {
        def comunidadInstance

        if(params.id) {
            comunidadInstance = Comunidad.get(params.id)
            if(!comunidadInstance) {
                render "no_No se encontró la comunidad"
                return
            }//no existe el objeto

            if(comunidadInstance?.numero.toInteger() == params.numero.toInteger()){
                comunidadInstance.properties = params
            }else{
                if(Comunidad.findAllByNumero(params.numero)){
                    render "no_Ya existe una comunidad registrada con este código!"
                    return
                }else{
                    comunidadInstance.properties = params
                }
            }
        }//es edit
        else {
            if(Comunidad.findAllByNumero(params.numero)){
                render "no_Ya existe una comunidad registrada con este código!"
                return
            }else{
                comunidadInstance = new Comunidad(params)
            }
        } //es create
        if (!comunidadInstance.save(flush: true)) {
            render "no_Error al guardar la comunidad"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente la comunidad "
            } else {
                render "ok_Se ha creado correctamente la comunidad "
            }
        }
    } //save
    def show_ajax() {
        def comunidadInstance = Comunidad.get(params.id)
        if (!comunidadInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Comunidad con id " + params.id
            redirect(action: "list")
            return
        }
        [comunidadInstance: comunidadInstance]
    }

    def borrarComunidad_ajax() {

        def comunidad = Comunidad.get(params.id)

        try{
            comunidad.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la comunidad " + e)
            render "no"
        }
    }

} //fin controller
