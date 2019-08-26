package seguridad

import org.springframework.dao.DataIntegrityViolationException

/**
 * Controlador que muestra las pantallas de manejo de Departamento
 */
class DepartamentoController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Departamento.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("direccion", "%" + params.search + "%")
                    ilike("email", "%" + params.search + "%")
                    ilike("fax", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                    ilike("objetivo", "%" + params.search + "%")
                    ilike("observaciones", "%" + params.search + "%")
                    ilike("sigla", "%" + params.search + "%")
                    ilike("telefono", "%" + params.search + "%")
                }
            }
        } else {
            list = Departamento.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return DepartamentoInstanceList: la lista de elementos filtrados, DepartamentoInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def DepartamentoInstanceList = getList(params, false)
        def DepartamentoInstanceCount = getList(params, true).size()
        return [DepartamentoInstanceList: DepartamentoInstanceList, DepartamentoInstanceCount: DepartamentoInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return DepartamentoInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
            return [departamentoInstance: departamentoInstance]
        } else {
            render "ERROR*No se encontró Departamento."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return DepartamentoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def departamentoInstance = new Departamento()
        if (params.id) {
            departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
        }
        departamentoInstance.properties = params
        return [departamentoInstance: departamentoInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def DepartamentoInstance = new Departamento()
        if (params.id) {
            DepartamentoInstance = Departamento.get(params.id)
            if (!DepartamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
        }
        DepartamentoInstance.properties = params
        if (!DepartamentoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Departamento: " + renderErrors(bean: DepartamentoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Departamento exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def DepartamentoInstance = Departamento.get(params.id)
            if (!DepartamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
            try {
                DepartamentoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Departamento exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Departamento"
                return
            }
        } else {
            render "ERROR*No se encontró Departamento."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad email
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_email_ajax() {
        params.email = params.email.toString().trim()
        if (params.id) {
            def obj = Departamento.get(params.id)
            if (obj.email.toLowerCase() == params.email.toLowerCase()) {
                render true
                return
            } else {
                render Departamento.countByEmailIlike(params.email) == 0
                return
            }
        } else {
            render Departamento.countByEmailIlike(params.email) == 0
            return
        }
    }

    /**
     * Acción que muestra la estructura institucional (Departamentoes y usuarios) en forma de árbol
     */
    def arbol() {}

    /**
     * Acción llamada con ajax que permite realizar búsquedas en el árbol
     */
    def arbolSearch_ajax() {
//        println "arbolSearch_ajax $params"
        def search = params.str.trim()
        if (search != "") {
            def c = Persona.createCriteria()
            def find = c.list(params) {
                or {
                    ilike("nombre", "%" + search + "%")
                    ilike("apellido", "%" + search + "%")
                    ilike("login", "%" + search + "%")
                    departamento {
                        or {
                            ilike("nombre", "%" + search + "%")
                        }
                    }
                }
            }
//            println find
            def departamentos = []
            find.each { pers ->
                if (pers.departamento && !departamentos.contains(pers.departamento)) {
                    departamentos.add(pers.departamento)
                    def dep = pers.departamento
                    def padre = dep.padre
                    while (padre) {
                        dep = padre
                        padre = dep.padre
                        if (!departamentos.contains(dep)) {
                            departamentos.add(dep)
                        }
                    }
                }
            }
            departamentos = departamentos.reverse()
            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                departamentos.each { dp ->
                    ids += "\"#lidep_" + dp.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"
            render ids
        } else {
            render ""
        }
    }

    /**
     * Acción llamada con ajax que carga el árbol de la estructura institucional
     */
    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }

    /**
     * Acción llamada con ajax que carga el árbol de proyectos
     */
    def loadTreeProyPart_ajax() {
        render(makeTreeProyNode(params))
    }

    /**
     * Función que genera el string del nodo requerido para el árbol de la estructura institucional
     * @param params
     * @return String
     */
    def makeTreeNode(params) {
//        println "makeTreeNode.. $params"
        def id = params.id
        if (!params.sort) {
            params.sort = "apellido"
        }
        if (!params.order) {
            params.order = "asc"
        }
        String tree = "", clase = "", rel = ""
        def padre
        def hijos = []

        if (id == "#") {
            //root
//            def hh = Departamento.countByPadreIsNull([sort: "nombre"])
            def hh = Departamento.countByPadreIsNull()
            if (hh > 0) {
                clase = "hasChildren jstree-closed"
            }

            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'>Estructura Principal</a>" +
                    "</li>"
            if (clase == "") {
                tree = ""
            }
        } else if (id == "root") {
            hijos = Departamento.findAllByPadreIsNull()
        } else {
            def parts = id.split("_")
            def node_id = parts[1].toLong()
            padre = Departamento.get(node_id)
            if (padre) {
                hijos = []
                hijos += Persona.findAllByDepartamento(padre, [sort: params.sort, order: params.order])
                hijos += Departamento.findAllByPadre(padre, [sort: "nombre"])
            }
        }

        if (tree == "" && (padre || hijos.size() > 0)) {
            tree += "<ul>"
            def lbl = ""

            hijos.each { hijo ->
                def tp = ""
                def data = ""
                def ico = ""
                if (hijo instanceof Departamento) {
                    lbl = hijo.nombre
//                    if (hijo.codigo) {
//                        lbl += " (${hijo.codigo})"
//                    }
                    tp = "dep"
                    def hijosH = Departamento.findAllByPadre(hijo, [sort: "nombre"])
                    if (hijo.padre) {
                        rel = (hijosH.size() > 0) ? "unidadPadre" : "unidadHijo"
                    } else {
                        rel = "principal"
                    }

                    if (hijo.padre) {
                        rel += hijo.activo ? "Activo" : "Inactivo"
                    }
                    hijosH += Persona.findAllByDepartamento(hijo, [sort: "apellido"])
                    clase = (hijosH.size() > 0) ? "jstree-closed hasChildren" : ""
                    if (hijosH.size() > 0) {
                        clase += " ocupado "
                    }
                } else if (hijo instanceof Persona) {
                    switch (params.sort) {
                        case 'apellido':
                            lbl = "${hijo.apellido} ${hijo.nombre} ${hijo.login ? '(' + hijo.login + ')' : ''}"
                            break;
                        case 'nombre':
                            lbl = "${hijo.nombre} ${hijo.apellido} ${hijo.login ? '(' + hijo.login + ')' : ''}"
                            break;
                        default:
                            lbl = "${hijo.apellido} ${hijo.nombre} ${hijo.login ? '(' + hijo.login + ')' : ''}"
                    }

                    if (hijo.esDirector) {
                        ico = ", \"icon\":\"fa fa-user-secret text-warning\""
                    } else if (hijo.esGerente) {
                        ico = ", \"icon\":\"fa fa-user-secret text-danger\""
                    }

                    tp = "usu"
                    rel = "usuario"
                    clase = "usuario"

                    data += "data-usuario='${hijo.login}'"

                    if (hijo.estaActivo == true) {
                        rel += "Activo"
                    } else {
                        rel += "Inactivo"
                    }
                }

                tree += "<li id='li${tp}_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${rel}\" ${ico}}' >"
                tree += "<a href='#' class='label_arbol'>" + lbl + "</a>"
                tree += "</li>"
            }

            tree += "</ul>"
        }
//        println "arbol: $tree"
        return tree
    }


    def arbol_asg() {

    }

    def cierreAnio() {
        def actual = params.anio ? Anio.get(params.anio) : Anio.findByAnio(new Date().format("yyyy").toInteger() - 1)

        def anios = Anio.findAllByAnioLessThanAndEstado(new Date().format("yyyy"), 0)

        println "anios: $anios"
        if (anios.size() == 0) {
            flash.message = "No hay añios pendientes de cierre"

        }
        [actual: actual, anios: anios]
    }

    def cerrarAnio() {
        println "params: $params"
        def anio = Anio.get(params.anio)
        anio.estado = 1     // 0 activo y modificacble cronograma, 1 cerrado
        def mesg = ""
        if (!anio.save(flush: true)) mesg = "Error al actualizar el anio ${anio.anio}"

        Departamento.findAll().each { ue ->
            ue.numeroAval = 0
            ue.numeroSolicitudAval = 0
            ue.numeroSolicitudReforma = 0
            if (!ue.save(flush: true)) {
                mesg += "error al actualizar la Unidad: ${ue.nombre}"
            }
        }
        if (mesg == "") {
            flash.message = "El año ${anio.anio} se ha cerrado correctamente"
        } else {
            flash.message = mesg
        }
        redirect(action: 'cierreAnio')
    }

}
