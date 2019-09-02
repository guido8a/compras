package compras

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

import org.springframework.dao.DataIntegrityViolationException

class ParroquiaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [parroquiaInstanceList: Parroquia.list(params), parroquiaInstanceTotal: Parroquia.count(), params: params]
    } //list

    def form_ajax() {
        def parroquiaInstance = new Parroquia(params)
        if (params.id) {
            parroquiaInstance = Parroquia.get(params.id)
            if (!parroquiaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Parroquia con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [parroquiaInstance: parroquiaInstance, padre: params.padre ?: parroquiaInstance?.canton?.id]
    } //form_ajax

    def fixCodigos() {
        def html = "<style>"
        html += "table{ border-collapse: collapse; }"
        html += "th{ padding: 5px; }"
        html += "td{ padding: 2px; }"
        html += "tr.ok, tr.ok td{ background-color: #93C19A; }"
        html += "tr.no, tr.no td{ background-color: #C1939B; }"
        html += "</style>"
        html += "<p>Se han cambiado los códigos de las siguientes parroquias: </p>"
        html += "<table border='1'>"
        html += "<tr>"
        html += "<thead>"
        html += "<th>Parroquia</th>"
        html += "<th>Cantón</th>"
        html += "<th>Código Cantón</th>"
        html += "<th>Código Parroquia</th>"
        html += "<th>Nuevo Código Parroquia</th>"
        html += "</thead>"
        html += "</tr>"
        def list = Parroquia.withCriteria {
            canton {
                order("numero", "asc")
            }
            order("codigo", "asc")
        }
        list.each { parr ->

            parr.codigo = parr.codigo.replaceAll(parr.canton.numero.padLeft(2, '0'), '')
            if (parr.codigo == '') {
                parr.codigo = parr.canton.numero.padLeft(2, '0')
            }
            def nc = parr.canton.numero.padLeft(2, '0') + parr.codigo.padLeft(2, '0')

            def ok = false
            if (Parroquia.countByCodigoAndIdNotEqual(nc, parr.id) > 0) {
                while (Parroquia.countByCodigoAndIdNotEqual(nc, parr.id) > 0) {
                    println "repetido: ${parr.id} ${nc}"
                    nc += "r"
                }
            }
            parr.codigo = nc
            if (parr.save(flush: true)) {
                ok = true
            } else {
                println parr.errors
            }

            html += "<tr class='${ok ? 'ok' : 'no'}'>"
            html += "<td>${parr.nombre}</td>"
            html += "<td>${parr.canton.nombre}</td>"
            html += "<td>${parr.canton.numero}</td>"
            html += "<td>${parr.codigo}</td>"
            html += "<td>${nc}</td>"
            html += "</tr>"
//            }
        }
        html += "</table>"
        render html
    }

    def save() {
        def parroquiaInstance

            if(params.id) {
                parroquiaInstance = Parroquia.get(params.id)
                if(!parroquiaInstance) {
                    render "no_No se encontró la parroquia"
                    return
                }//no existe el objeto

                if(parroquiaInstance?.codigo.toInteger() == params.codigo.toInteger()){
                    parroquiaInstance.properties = params
                }else{
                    if(Parroquia.findAllByCodigo(params.codigo)){
                        render "no_Ya existe una parroquia registrada con este código!"
                        return
                    }else{
                        parroquiaInstance.properties = params
                    }
                }
            }//es edit
            else {
                if(Parroquia.findAllByCodigo(params.codigo)){
                    render "no_Ya existe una parroquia registrada con este código!"
                    return
                }else{
                    parroquiaInstance = new Parroquia(params)
                }
            } //es create
            if (!parroquiaInstance.save(flush: true)) {
                render "no_Error al guardar la parroquia"
                return
            }else{
                if(params.id) {
                    render  "ok_Se ha actualizado correctamente la parroquia "
                } else {
                    render "ok_Se ha creado correctamente la parroquia "
                }
            }
    } //save

    def show_ajax() {
        def parroquiaInstance = Parroquia.get(params.id)
        if (!parroquiaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Parroquia con id " + params.id
            redirect(action: "list")
            return
        }
        [parroquiaInstance: parroquiaInstance]
    } //show

    def borrarParroquia_ajax() {

        def parroquia = Parroquia.get(params.id)

        try{
            parroquia.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la parroquia " + e)
            render "no"
        }
    }
} //fin controller
