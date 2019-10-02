package utilitarios


class ParametrosController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond parametrosService.list(params), model:[parametrosCount: parametrosService.count()]
    }

    def list () {

    }
}
