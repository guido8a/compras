<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/02/20
  Time: 11:40
--%>

<div class="" style="width: 99.7%;height: 310px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${lista}" var="detalle" status="z">
            <tr>
                <td style="width: 8%; text-align: right">
                    ${detalle.value[1]}
                </td>
                <td style="width: 30%; text-align: left">
                    ${detalle.value[3]}
                </td>
                <td style="width: 15%;">
                    ${detalle.value[4]}
                </td>
                <td style="width: 12%; text-align: center; background-color: ${detalle.value[2] == 'PROFORMA' ? '#ffca87' : '#5596ff'}">

                    <div class="main">
                        <div class="text" style="text-align: left">${detalle.value[2]}</div>
                        <div class="percentage">
                            <div style="color: ${detalle.value[6] == 'I' ? '#5596ff' : '#a32713'}">
                                ${detalle.value[6] == 'I' ? 'EXTRANJERO' : 'NACIONAL'}
                            </div>
                        </div>
                    </div>
                </td>
                <td style="width: 5%; text-align: center">
                    <a href="#" class="btn btn-success btn-xs btnSeleccionarPrecio" title="Seleccionar precio" data-precio="${detalle.value[1]}" data-origen="${detalle.value[5]}" data-nombre="${detalle.value[2]}" data-id="${detalle?.key}"><i class="fa fa-check"></i></a>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">
    $(".btnSeleccionarPrecio").click(function () {
        var precio = $(this).data("precio");
        var origen = $(this).data("origen");
        var origenNombre = $(this).data("nombre");
        var idOrigen = $(this).data("id");
        $("#precioUnitario").val(precio);
        $("#origen").val(origen);
        $("#origen_name").val(origenNombre);
        $("#idOrigen").val(idOrigen);
        $('.bootbox.modal').modal('hide');
    });
</script>
