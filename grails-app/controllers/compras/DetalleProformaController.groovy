package compras

class DetalleProformaController {

    def agregarDetallePrecio_ajax () {

//        println("params detalle " + params)

        def detalleProforma

        def item = Item.get(params.item)
        def proforma = Proforma.get(params.proforma)
        def existente = DetalleProforma.findByItemAndProforma(item, proforma)

        if(existente){
            render "me_El item seleccionado ya existe en la proforma"
        }else{
            if(params.id){
                detalleProforma = DetalleProforma.get(params.id)
            }else{
                detalleProforma = new DetalleProforma()
            }

            detalleProforma.properties = params

            if(!detalleProforma.save(flush: true)){
                println("error al guardar detalle proforma " + detalleProforma.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    }

    def tablaDetalleProforma () {
        def proforma = Proforma.get(params.proforma)
        def detalles = DetalleProforma.findAllByProforma(proforma)
        return[lista: detalles, proforma: proforma]
    }


    def borrarDetalleProforma_ajax (){

//        println("params bdp " + params)

        def detalle = DetalleProforma.get(params.id)
        def existe = Precio.findAllByDetalleProforma(detalle)


        if(existe){
            render "er_No se puede borrar el item del detalle de la proforma, ya se encuentra asignado al detalle:" + '<br>' + "${existe?.detallePrecio?.proyecto?.nombre}"
        }else{
            try{
                detalle.delete(flush: true)
                render "ok"
            }catch(e){
                println("error al borrar el detalle proforma " + detalle.errors + " " + e)
                render "no"
            }
        }



    }

}
