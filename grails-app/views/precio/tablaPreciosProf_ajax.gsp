<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/01/20
  Time: 9:18
--%>
<script type="text/javascript">

    function borrarPrecioProforma(id, detalle){
        bootbox.confirm({
            title: "Borrar precio del item",
            message: "Está seguro de borrar este precio de la lista? Esta acción no puede deshacerse.",
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
                        url: '${createLink(controller: 'precio', action: 'borrarPrecio_ajax')}',
                        data:{
                            id: id
                        },
                        success: function (msg) {
                            dialog.modal('hide');
                            if(msg == 'ok'){
                                log("Precio borrado correctamente","success");
                                cargarTablaProforma(detalle);
                                limpiarPrecioProforma(detalle)
                            }else{
                                log("Error al borrar el precio", "error")
                            }
                        }
                    });
                }
            }
        });
    }
</script>

<div class="" style="width: 99.7%;height: 100px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${lista}" var="precio" status="z">
            <tr id="tpp_${detalle?.id}">
                <td style="width: 15%; text-align: center">
                    ${z + 1}
                </td>
                <td style="width: 35%">
                    ${precio.valor}
                </td>
                <td style="width: 10%">
                    <g:if test="${detalle?.proyecto?.estado != 'R'}">
                        <a href="#" class="btn btn-danger btn-xs btnBorrarPrecioProforma" onclick="borrarPrecioProforma('${precio.id}', '${precio?.detallePrecio?.id}')" title="Borrar precio"><i class="fa fa-trash"></i> </a>
                    </g:if>
                </td>
            </tr>
        </g:each>
    </table>
</div>
