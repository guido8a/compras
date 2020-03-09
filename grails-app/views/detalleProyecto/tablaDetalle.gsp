<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 29/11/19
  Time: 11:08
--%>


<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}

.recolor{
    background-color: #5596ff !important;
}

.precioColor{
    background-color: #e1a628 !important;
}

</style>

<script type="text/javascript">
    function cargarTablaProforma(detalle) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'precio', action: 'tablaPreciosProf_ajax')}",
            data:{
                detalle: detalle
            } ,
            success: function (msg){
                $("#divTablaProforma_" + detalle).html(msg)
            }
        });
    }

    function cargarTablaDetalleDet(detalle) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'precio', action: 'tablaPreciosDet_ajax')}",
            data:{
                detalle: detalle
            } ,
            success: function (msg){
                $("#divTablaDetalle_" + detalle).html(msg)
            }
        });
    }
</script>

<div class="" style="width: 99.7%;height: 470px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover tabla" style="width: 100%">
        <g:each in="${lista}" var="detalle" status="z">
            <tr id="tr_${detalle?.id}">
                <td style="width: 5%">
                    ${detalle?.orden}
                </td>
                <td style="width: 7%">
                    ${detalle?.item?.codigo}
                </td>
                <td style="width: 36%">
                    ${detalle?.item?.nombre}
                </td>
                <td style="width: 23%">
                    <div class="accordion" id="accordionExample">
                        <div class="card">
                            <div class="card-header" id="headingOne_${detalle?.id}">
                                <h2 class="mb-0">
                                    <button class="btn btn-info" type="button" data-toggle="collapse" data-target="#collapseOne_${detalle?.id}" aria-expanded="true" aria-controls="collapseOne">
                                        <i class="fa fa-search-dollar"></i> Proforma
                                    </button>
                                    <button class="btn btn-success collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo_${detalle?.id}" aria-expanded="false" aria-controls="collapseTwo">
                                        <i class="fa fa-search-dollar"></i> Detalle
                                    </button>
                                </h2>
                            </div>

                            <div id="collapseOne_${detalle?.id}" class="collapse" aria-labelledby="headingOne_${detalle?.id}" data-parent="#accordionExample">
                                <script>
                                    cargarTablaProforma('${detalle?.id}')
                                </script>
                                <div class="card-body" >
                                    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #3cbcd9">
                                        <thead>
                                        <tr>
                                            <th class="alinear"  style="width: 15%">#</th>
                                            <th class="alinear"  style="width: 35%">Valor</th>
                                            <th class="alinear" style="width: 10%"></th>
                                        </tr>
                                        </thead>
                                    </table>
                                    <div id="divTablaProforma_${detalle?.id}">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div id="collapseTwo_${detalle.id}" class="collapse" aria-labelledby="headingTwo_${detalle?.id}" data-parent="#accordionExample">
                                <script>
                                    cargarTablaDetalleDet('${detalle?.id}')
                                </script>
                                <div class="card-body" >
                                    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #78b665">
                                        <thead>
                                        <tr>
                                            <th class="alinear"  style="width: 15%">#</th>
                                            <th class="alinear"  style="width: 35%">Valor</th>
                                            <th class="alinear" style="width: 10%"></th>
                                        </tr>
                                        </thead>
                                    </table>
                                    <div id="divTablaDetalle_${detalle?.id}">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <td style="width: 8px; text-align: center">
                    <strong id="textoPrecioDefinitivo_${detalle?.id}">${detalle?.precioUnitario ?: 0.00}</strong> <br>
                    <g:if test="${proyecto?.estado != 'R'}">
                        <a href="#" class="btn btn-primary btnSeleccionarPrecio btn-xs" data-id="${detalle?.id}" title="Seleccionar precio unitario"><i class="fa fa-hand-holding-usd"></i></a>
                    </g:if>
                </td>
                <td style="width: 6%; text-align: center;">
                    <strong>${detalle?.cantidad}</strong>
                </td>
                <td style="width: 7%; text-align: center">
                    <strong id="textoSubtotal_${detalle?.id}">${detalle?.subtotal}</strong>
                </td>
                <td style="width: 8%">
                    <g:if test="${proyecto?.estado != 'R'}">
                        <a href="#" class="btn btn-warning btn-xs btnPrecios" data-id="${detalle?.id}" title="Precios"><i class="fa fa-dollar-sign"></i></a>
                        <a href="#" class="btn btn-info btn-xs btnEditar" data-id="${detalle?.id}" title="Editar"><i class="fa fa-edit"></i></a>
                        <a href="#" class="btn btn-danger btn-xs btnBorrar" data-id="${detalle?.id}" title="Borrar"><i class="fa fa-trash"></i></a>
                    </g:if>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    function limpiarPrecioProforma(detalle) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'precio', action: 'limpiarPrecioProforma_ajax')}",
            data:{
                detalle: detalle
            },
            success: function (msg){
                if(msg == 'ok'){
                    cargarSubtotal(detalle);
                    cargarPrecioDefinitivo(detalle);
                    limpiarPrecioUnitario(detalle)
                }
            }
        });
    }

    function limpiarPrecioDetalle(detalle) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'precio', action: 'limpiarPrecioDetalle_ajax')}",
            data:{
                detalle: detalle
            },
            success: function (msg){
                if(msg == 'ok'){
                    cargarSubtotal(detalle);
                    cargarPrecioDefinitivo(detalle);
                    limpiarPrecioUnitario(detalle)
                }
            }
        });
    }


    function cargarPrecioDefinitivo(detalle){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'precio', action: 'verificarPrecioDefinitivo_ajax')}',
            data:{
                detalle: detalle
            },
            success: function (msg) {
                $("#textoPrecioDefinitivo_" + detalle).html(msg)
            }
        })
    }

    function limpiarPrecioUnitario(detalle) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'precio', action: 'limpiarPrecioUnitario_ajax')}",
            data:{
                detalle: detalle
            },
            success: function (msg){
                if(msg == 'ok'){
                    cargarSubtotal(detalle);
                    cargarPrecioDefinitivo(detalle);
                }
            }
        });
    }

    function cargarSubtotal (detalle) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'precio', action: 'subtotal_ajax')}",
            data:{
                detalle: detalle
            },
            success: function (msg) {
                $("#textoSubtotal_" + detalle).html(msg)
            }
        })
    }

   $(".btnSeleccionarPrecio").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'precio', action: 'seleccionPrecios_ajax')}",
            data:{
                detalle: id
            },
            success: function (msg) {
                bootbox.dialog({
                    id    : 'dlgSeleccionarPrecio',
                    title : "Seleccionar precio",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            }
        });
    });

    function mensajeError(mensaje){
        return  bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + mensaje + '</strong>');
    }

    $(".btnBorrar").click(function () {
        var id = $(this).data("id");
        bootbox.confirm({
            title: "Borrar Item del detalle",
            message: "Está seguro de borrar este item del detalle? Esta acción no puede deshacerse.",
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> Cancelar',
                    className: 'btn-primary'
                },
                confirm: {
                    label: '<i class="fa fa-trash"></i> Borrar',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if(result){
                    var dialog = cargarLoader("Borrando...");
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'detalleProyecto', action: 'borrarDetalle_ajax')}',
                        data:{
                            id: id
                        },
                        success: function (msg) {
                            dialog.modal('hide');
                            var parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                log("Item borrado correctamente","success");
                                setTimeout(function () {
                                    cargarTablaDetalle('${proyecto?.id}')
                                }, 500);
                            }else{
                                if(parts[0] == 'er'){
                                    mensajeError(parts[1]);
                                }else{
                                    log("Error al borrar el Item", "error")
                                }
                            }
                        }
                    });
                }
            }
        });
    });

    $(".btnEditar").click(function () {
        var id = $(this).data("id");
        var detalle = $(this).data("det");
        $(".tabla tr").removeClass("recolor");
        $("#tr_" + id).removeClass("precioColor").addClass("recolor");
        $(".divEditar").addClass("bordeColor");
        $(".divEditarPrecio").removeClass("bordeColor2");
        $(".btnCancelar").removeClass("hidden");
        $(".btnGuardar").removeClass("hidden");
        $(".btnAgregar").addClass("hidden");
        $(".btnBusqueda").removeClass("hidden");
        $(".btnBuscarPrecio").addClass("hidden");
        $(".btnAgregarPrecio").addClass("hidden");
        $(".btnCancelarPrecio").addClass("hidden");
        $("#detalle").val(id);
        buscarItemEditar(id,1);
    });

    function buscarItemEditar(id, tipo) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: "detalleProyecto", action: 'buscarDetalle_ajax')}",
            data:{
                id: id
            },
            success: function(msg){
                var parts = msg.split("_");
                $("#item").val(parts[0]);
                $("#codigo").val(parts[1]);
                $("#nombre").val(parts[2]);
                $("#cantidad").val(parts[3]);
                // $("#precioUnitario").val(parts[4]);
                $("#orden").val(parts[5]);
                // $("#origen_name").val(parts[6] == 'P' ? 'PROFORMA' : 'DETALLE');
                // $("#origen").val(parts[6]);
            }
        });
    }

    $(".btnPrecios").click(function () {
        var id = $(this).data("id");
        var detalle = $(this).data("det");
        $(".tabla tr").removeClass("precioColor");
        $("#tr_" + id).removeClass("recolor").addClass("precioColor");
        $(".divEditarPrecio").addClass("bordeColor2");
        $(".divEditar").removeClass("bordeColor");
        $(".btnCancelar").addClass("hidden");
        $(".btnGuardar").addClass("hidden");
        $(".btnAgregar").addClass("hidden");
        $(".btnBusqueda").addClass("hidden");
        $(".btnBuscarPrecio").removeClass("hidden");
        $(".btnAgregarPrecio").removeClass("hidden");
        $(".btnCancelarPrecio").removeClass("hidden");
        $("#detalle").val(id);
        $("#origen_name").val('');
        $("#origen").val('');
        $("#idOrigen").val('');
        $("#precioUnitario").val('');
        buscarItemEditar(id,2);
    });

</script>
