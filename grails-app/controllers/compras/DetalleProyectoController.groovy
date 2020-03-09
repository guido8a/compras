package compras


class DetalleProyectoController {

    def agregarItem_ajax () {

        println("params si " + params)

        def detalle
        def item = Item.get(params.item)
        def proyecto = Proyecto.get(params.proyecto)
        def existente = DetalleProyecto.findByItemAndProyecto(item,proyecto)


        if(params.detalle){
            detalle = DetalleProyecto.get(params.detalle)

            if(item == detalle.item){
                detalle.properties = params
            }else{
                if(existente){
                    render "er_El item ya se encuentra asignado"
                }else{
                    detalle.properties = params
                }
            }
        }else{
            if(existente){
                render "er_El item ya se encuentra asignado"
            }else{
                detalle = new DetalleProyecto()
                detalle.properties = params
            }
        }


        if(!detalle.save(flush: true)){
            println("error al guardar el item al detalle " + detalle.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def tablaDetalle () {
//        println("params td " + params)
        def proyecto = Proyecto.get(params.id)
        def detalles = DetalleProyecto.findAllByProyecto(proyecto).sort{it.orden}
        return [lista: detalles, proyecto: proyecto]
    }

    def buscarDetalle_ajax() {
        def detalle = DetalleProyecto.get(params.id)
        render detalle.item.id + "_" + detalle.item.codigo + "_" + detalle.item.nombre + "_" +  detalle.cantidad + "_" + detalle.precioUnitario + "_" + detalle.orden
    }

    def borrarDetalle_ajax () {
        def detalle = DetalleProyecto.get(params.id)

        def precios = Precio.findAllByDetallePrecio(detalle)

        if(precios){
            render"er_Existe precios asociados al item, no se puede borrar"
        }else{
            try{
                detalle.delete(flush: true)
                render "ok"
            }catch(e){
                println("error al borrar el detalle " + detalle.errors + e)
                render "no"
            }
        }
    }

    def revisarOrden_ajax () {

//        println("params ro " + params)

        def detalle
        def ordenes
        def proyecto = Proyecto.get(params.proyecto)

        if(params.detalle != ''){

            detalle = DetalleProyecto.get(params.detalle)

            if(detalle.orden == params.orden.toInteger()){
                render "ok"
            }else{
                ordenes = DetalleProyecto.findAllByOrdenAndProyecto(params.orden.toInteger(),proyecto)
                if(ordenes.size() > 0){
                    render "no"
                }else{
                    render "ok"
                }
            }
        }else{
            ordenes = DetalleProyecto.findAllByOrdenAndProyecto(params.orden.toInteger(),proyecto)
            if(ordenes.size() > 0){
                render "no"
            }else{
                render "ok"
            }
        }
    }

 }
