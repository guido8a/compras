<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/01/20
  Time: 12:39
--%>

<g:if test="${detalle?.precioProyecto || detalle?.precioProforma}">
    <tr style="background-color: #e1a628">
        <g:each in="${valores.values()}" var="valor">
            <td>${valor}</td>
        </g:each>
    </tr>
    <tr>
    <g:radioGroup name="precioDefinitivo" onclick="guardarValorDefinitivo()"
                  values="${valores}"
                  labels="${etiquetas}"
                  value="${detalle?.criterio?.id + "="+ detalle?.precioUnitario}">
        <p><td>${it.label} ${it.radio}</td></p>
    </g:radioGroup>
    </tr>
</g:if>
<g:else>
    <br> * Para visualizar los precios definitivos, seleccione un precio en proforma o detalle.
</g:else>

<script type="text/javascript">

    function guardarValorDefinitivo() {
        var dialog = cargarLoader("Guardando...");
        var detalle= '${detalle?.id}';
        var id= $('input:radio[name=precioDefinitivo]:checked').val();
        var label= $('input:radio[name=precioDefinitivo]:checked').parent().text();
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'precio', action: 'guardarPrecioDefinitivo_ajax')}",
            data:{
                detalle: detalle,
                valor: id,
                label: label,
                fuente: '${fuente}'
            },
            success: function (msg){
                dialog.modal('hide');
                if(msg == 'ok'){
                    log("Precio guardado correctamente","success");
                    cargarListaPreciosDefinitivos();
                    cargarPrecioDefinitivo('${detalle?.id}');
                    cargarSubtotal('${detalle?.id}')
                }else{
                    log("Error al guardar el precio","error");
                }
            }
        });
    }

    %{--function cargarPrecioDefinitivo(detalle){--}%
    %{--    $.ajax({--}%
    %{--        type: 'POST',--}%
    %{--        url: '${createLink(controller: 'precio', action: 'verificarPrecioDefinitivo_ajax')}',--}%
    %{--        data:{--}%
    %{--            detalle: detalle--}%
    %{--        },--}%
    %{--        success: function (msg) {--}%
    %{--            $("#textoPrecioDefinitivo").html(msg)--}%
    %{--        }--}%
    %{--    })--}%
    %{--}--}%

</script>