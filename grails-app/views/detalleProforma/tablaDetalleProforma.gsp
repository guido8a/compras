<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/12/19
  Time: 9:54
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

</style>

<div class="" style="width: 99.7%;height: 270px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover tabla" style="width: 100%">
        <g:each in="${lista}" var="detalle" status="z">
            <tr id="tr_${detalle?.id}">
                <td style="width: 15%">
                    ${detalle?.item?.codigo}
                </td>
                <td style="width: 45%">
                    ${detalle?.item?.nombre}
                </td>
                <td style="width: 15%; text-align: right; font-weight: bolder; font-size: 12px">
                    ${detalle?.precioUnitario}
                </td>
                <td style="width: 15%; text-align: center">
                    ${detalle?.procedencia == 'N' ? 'NACIONAL' : 'EXTRANJERO'}
                </td>
                <td style="width: 5%">
                    <g:if test="${proforma?.estado != 'R'}">
                        <a href="#" class="btn btn-danger btn-sm btnBorrarDetalleProforma" data-id="${detalle?.id}" title="Borrar"><i class="fa fa-trash"></i></a>
                    </g:if>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnBorrarDetalleProforma").click(function () {
        var idDetalle = $(this).data("id");

        bootbox.confirm({
            title: "Borrar Item",
            message: "<i class='fa fa-exclamation-triangle text-danger fa-3x'></i> Está seguro de borrar esta item de la proforma? Esta acción no puede deshacerse.",
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
                        url: "${createLink(controller: 'detalleProforma', action: 'borrarDetalleProforma_ajax')}",
                        data:{
                            id: idDetalle
                        },
                        success: function (msg) {
                            dialog.modal('hide');
                            var parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                log("Item borrado correctamente","success");
                                cargarTablaDetalles('${proforma?.id}');
                            }else{
                                if(parts[0] == 'er'){
                                    mensajeError(parts[1])
                                }else{
                                    log("Error al borrar el item","error")
                                }
                            }
                        }
                    });
                }
            }
        });
    });

    function mensajeError(mensaje){
        return  bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 13px">' + mensaje + '</strong>');
    }

</script>