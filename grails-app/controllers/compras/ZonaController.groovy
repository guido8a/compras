package compras

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ZonaController {

    ZonaService zonaService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond zonaService.list(params), model:[zonaCount: zonaService.count()]
    }

    def show(Long id) {
        respond zonaService.get(id)
    }

    def create() {
        respond new Zona(params)
    }

    def save(Zona zona) {
        if (zona == null) {
            notFound()
            return
        }

        try {
            zonaService.save(zona)
        } catch (ValidationException e) {
            respond zona.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'zona.label', default: 'Zona'), zona.id])
                redirect zona
            }
            '*' { respond zona, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond zonaService.get(id)
    }

    def update(Zona zona) {
        if (zona == null) {
            notFound()
            return
        }

        try {
            zonaService.save(zona)
        } catch (ValidationException e) {
            respond zona.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'zona.label', default: 'Zona'), zona.id])
                redirect zona
            }
            '*'{ respond zona, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        zonaService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'zona.label', default: 'Zona'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }



    def list() {

    }

    def tablaZona () {
        def lista = Zona.list().sort{it.nombre}
        return [lista: lista]
    }

    def show_ajax() {
        if (params.id) {
            def zonaInstance = Zona.get(params.id)
            if (!zonaInstance) {
                notFound_ajax()
                return
            }
            return [zonaInstance: zonaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def zonaInstance = new Zona(params)
        if (params.id) {
            zonaInstance = Zona.get(params.id)
            if (!zonaInstance) {
                notFound_ajax()
                return
            }
        }
        return [zonaInstance: zonaInstance]
    } //form para cargar con ajax en un dialog

    protected void notFound_ajax() {
        render "NO_No se encontró la Zona."
    } //notFound para ajax

    def save_ajax () {
        println("params " + params)

        def zona

        if(params.id){
            zona = Zona.get(params.id)
            zona.properties = params
        }else{
            zona = new Zona()
            zona.properties = params
        }


        try{
            zona.save(flush: true)
            render "OK"
        }catch(e){
            println("error al guardar la zona " + e)
            render "NO"
        }

    }


}
