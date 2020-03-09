package compras


class PrecioController {

    def precio () {

    }

    def buscarPreciosProformas () {

    }

    def buscarPreciosDetalles () {

    }

    def agregarPrecio_ajax () {

//        println("params ap " + params)

        def precio
        def origen
        def existente
        def fuenteOrigen
        def detalleProyecto = DetalleProyecto.get(params.idDetalle)
        def cantidad
        def fuentesProformas = Precio.findAllByDetallePrecioAndDetalleProformaIsNotNull(detalleProyecto)?.detalleProforma?.procedencia
        def fuentesProyectos = Precio.findAllByDetallePrecioAndDetalleProyectoIsNotNull(detalleProyecto)?.detalleProyecto?.fuente

//        println(fuentesProformas as Set)

        if(params.origen == 'P'){
            origen = DetalleProforma.get(params.idPrecio)
            params.pro = origen
            params.det = null
            existente = Precio.findAllByDetalleProformaAndDetallePrecio(origen, detalleProyecto)
            cantidad = Precio.findAllByDetallePrecioAndDetalleProformaIsNotNull(detalleProyecto)
            fuenteOrigen = origen.procedencia
        }else{
            origen = DetalleProyecto.get(params.idPrecio)
            params.pro = null
            params.det = origen
            existente = Precio.findAllByDetalleProyectoAndDetallePrecio(origen, detalleProyecto)
            cantidad = Precio.findAllByDetallePrecioAndDetalleProyectoIsNotNull(detalleProyecto)
            fuenteOrigen = origen.fuente
        }

        if(existente){
            render "er_Este precio ya se encuentra asignado!"
        }else{

//            println("fo " + fuenteOrigen)
//            println("--> " + fuentesProformas)
//            println("-->2 " + fuentesProyectos)

            def bandProforma = false
            def bandProyecto = false

            if(fuentesProformas.size() > 0){
                bandProforma = fuentesProformas.contains(fuenteOrigen)
            }else{
                bandProforma = true
            }

            if(fuentesProyectos.size() > 0){
                bandProyecto = fuentesProyectos.contains(fuenteOrigen)
            }else{
                bandProyecto = true
            }

//            println("1 " + bandProforma)
//            println("2 " + bandProyecto)

            if(bandProyecto && bandProforma){
                if(cantidad.size() < 3){
                    if(params.id){
                        precio = Precio.get(params.id)
                    }else{
                        precio = new Precio()
                    }

                    precio.detalleProforma = params.pro
                    precio.detalleProyecto = params.det
                    precio.detallePrecio = detalleProyecto
                    precio.valor = params.precio.toDouble()

                    if(!precio.save(flush: true)){
                        render "no"
                        println("error al guardar el precio en el detalle " + precio.errors)
                    }else{
                        render "ok"
                    }
                }else{
                    render "er_No se puede asignar más precios a  ${params.origen == 'P' ? 'Proformas' : 'Detalles'}"
                }
            }else{
                render "er_La procedencia del precio seleccionado: ${fuenteOrigen == 'I' ? 'EXTRANJERO' : 'NACIONAL'}, no es la misma procedencia de los precios ya asignados al item!"
            }
        }
    }

    def tablaPreciosProf_ajax () {

//        println("params tpp " + params)

        def detalleProyecto = DetalleProyecto.get(params.detalle)
        def precios = Precio.findAllByDetallePrecioAndDetalleProformaIsNotNull(detalleProyecto)
        return[lista: precios, detalle: detalleProyecto]
    }

    def tablaPreciosDet_ajax () {

//        println("params tpp " + params)

        def detalleProyecto = DetalleProyecto.get(params.detalle)
        def precios = Precio.findAllByDetallePrecioAndDetalleProyectoIsNotNull(detalleProyecto)
        return[lista: precios, detalle: detalleProyecto]
    }

    def borrarPrecio_ajax () {

        def precio = Precio.get(params.id)
        try{
            precio.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el precio " + e)
            render "no"
        }
    }

    def revisarExistentes_ajax () {

        def detalle = DetalleProyecto.get(params.detalle)
        def precios = Precio.findAllByDetallePrecio(detalle)

//        println("precios " + precios.size())

        if(precios.size() > 0){
            render "no"
        }else{
            render "ok"
        }
    }

    def seleccionPrecios_ajax () {

//        println("params " + params)

        def detalle = DetalleProyecto.get(params.detalle)
        def proformas = Precio.findAllByDetalleProformaIsNotNullAndDetallePrecio(detalle).sort{it.valor}
        def proyecto = Precio.findAllByDetalleProyectoIsNotNullAndDetallePrecio(detalle).sort{it.valor}

        def fuenteProforma = proformas?.detalleProforma?.procedencia?.unique()
        def fuenteProyecto = proyecto?.detalleProyecto?.fuente?.unique()

//        println("p1 " + fuenteProforma[0])
//        println("p2 " + fuenteProyecto[0])

        def fuente = (fuenteProforma[0] ? fuenteProforma[0] : (fuenteProyecto[0] ? fuenteProyecto[0] : null))

        def mayorPf = proformas.valor.max()
        def mayorPy = proyecto.valor.max()
        def menorPf = proformas.valor.min()
        def menorPy = proyecto.valor.min()

        def avg = { list -> list == [] ? 0 : list.sum() / list.size() }

        def promPf = avg(proformas.valor).round(2)
        def promPy = avg(proyecto.valor).round(2)

        def medPf
        def medPy

        if(proformas.size() > 0) {
            if(proformas.size() == 1){
                medPf = proformas.valor[0]
            }else{
                if(proformas.size() == 2){
                    medPf = avg(proformas.valor).round(2)
                }else{
                    medPf = proformas.valor[1]
                }
            }
        }

        if(proyecto.size() > 0) {
            if(proyecto.size() == 1){
                medPy = proyecto.valor[0]
            }else{
                if(proyecto.size() == 2){
                    medPy = avg(proyecto.valor).round(2)
                }else{
                    medPy = proyecto.valor[1]
                }
            }
        }

//        def valoresProforma = [menorPf,mayorPf,promPf,medPf]
//        def valoresProyecto = [menorPy, mayorPy, promPy, medPy]

        def valoresProforma = [2:menorPf, 1:mayorPf, 4:promPf, 3:medPf]
        def valoresProyecto = [2:menorPy, 1:mayorPy, 4:promPy, 3:medPy]
        def etiquetas = ["Menor","Mayor","Promedio","Mediana"]
//        def etiquetas = ["Mayor","Menor","Mediana", "Promedio"]

//        println("m " + medPf)
//        println("m " + medPy)

        return[detalle: detalle, valoresPf: valoresProforma, valoresPy: valoresProyecto, etiquetas: etiquetas, tamanoProformas: proformas.size(), tamanoProyecto: proyecto.size(), fuente: fuente]

    }

    def guardarPrecioProforma_ajax () {

//        println("params pprof" + params )

        def d = params.valor.split("=")
        def detalle = DetalleProyecto.get(params.detalle)

        def idC = idEtiquetas(params.label.trim())
        def criterio= Criterio.get(idC)

        detalle.criterioProforma = criterio
        detalle.precioProforma = d[1]?.toDouble()

        if(!detalle.save(flush: true)){
            println("error al guardar el precio de la proforma " + detalle.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def guardarPrecioProyecto_ajax () {

//        println("params pproy" + params )

        def d = params.valor.split("=")
        def detalle = DetalleProyecto.get(params.detalle)

        def idC = idEtiquetas(params.label.trim())
        def criterio= Criterio.get(idC)

        detalle.criterioProyecto = criterio
        detalle.precioProyecto = d[1]?.toDouble()
        if(!detalle.save(flush: true)){
            println("error al guardar el precio del detalle " + detalle.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def idEtiquetas(tipo){

        def idCriterio

        switch(tipo){
            case "Menor":
                idCriterio = 2
                break;
            case "Mayor":
                idCriterio = 1
                break;
            case "Promedio":
                idCriterio = 4
                break;
            case "Mediana":
                idCriterio = 3
                break;
            case "Único":
                idCriterio = 5
                break;
        }

        return idCriterio
    }


    def definitivoPrecio_ajax () {

        def detalle = DetalleProyecto.get(params.detalle)

        def precios = []
        if(detalle?.precioProyecto != 0.00){
            precios.add(detalle?.precioProyecto)
        }

        if(detalle?.precioProforma != 0.00 ){
            precios.add(detalle?.precioProforma)
        }

//        println("precios " + precios  )

        def menor = precios.min()
        def mayor = precios.max()

        def avg = { list -> list == [] ? 0 : list.sum() / list.size() }

        def promedio = avg(precios).round(2)

        def unico

        if(detalle?.precioProforma && !detalle?.precioProyecto){
            unico = detalle?.precioProforma
        }else{
            if(!detalle?.precioProforma && detalle?.precioProyecto){
                unico = detalle?.precioProyecto
            }
        }

//        println("unico " + detalle?.precioProforma)
//        println("unico " + detalle?.precioProyecto)

        def valores
        def etiquetas

        if(unico){
            valores = [5:unico]
            etiquetas = ["Único"]
        }else{
            valores = [2:menor, 1:mayor, 4:promedio]
            etiquetas = ["Menor","Mayor","Promedio"]
        }

        return [valores: valores, etiquetas: etiquetas, detalle: detalle, fuente: params.fuente]
    }

    def guardarPrecioDefinitivo_ajax () {

        println("params gpd " +  params)

        def d = params.valor.split("=")

        def detalle = DetalleProyecto.get(params.detalle)
//        def idC = idEtiquetas(params.label.trim())
        def criterio= Criterio.get(d[0])

        detalle.criterio = criterio
        detalle.precioUnitario = d[1]?.toDouble()
        detalle.subtotal = (detalle?.precioUnitario ?: 0) * (detalle?.cantidad ?: 0)
        detalle.fuente = params.fuente

        if(!detalle.save(flush: true)){
            println("error al guardar el precio " + detalle.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def verificarPrecioDefinitivo_ajax () {
        def detalle = DetalleProyecto.get(params.detalle).precioUnitario
        render detalle
    }

    def subtotal_ajax () {
        def detalle = DetalleProyecto.get(params.detalle).subtotal
        render detalle
    }

    def limpiarPrecioUnitario_ajax () {
        def detalle = DetalleProyecto.get(params.detalle)

        detalle.precioUnitario = 0
        detalle.criterio = null
        detalle.subtotal = 0

        if(!detalle.save(flush:true)){
            println("error al limpiar el precio unitario " + detalle.errors)
            render"no"
        }else{
            render "ok"
        }
    }

    def limpiarPrecioProforma_ajax () {
        def detalle = DetalleProyecto.get(params.detalle)

        detalle.precioProforma = 0
        detalle.criterioProforma = null

        if(!detalle.save(flush:true)){
            println("error al limpiar el precio proforma " + detalle.errors)
            render"no"
        }else{
            render "ok"
        }
    }

    def limpiarPrecioDetalle_ajax () {
        def detalle = DetalleProyecto.get(params.detalle)

        detalle.precioProyecto = 0
        detalle.criterioProyecto = null

        if(!detalle.save(flush:true)){
            println("error al limpiar el precio proyecto " + detalle.errors)
            render"no"
        }else{
            render "ok"
        }
    }


    def revisarUso_ajax (id) {

        def detalle = DetalleProyecto.get(id)
        def precios = Precio.findAllByDetalleProyecto(detalle)

//        println("precios " + precios)

        if(precios){
            return "ok_" + precios?.detallePrecio?.proyecto?.nombre
        }else{
            return "no"
        }
    }

}
