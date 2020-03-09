<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/12/19
  Time: 11:53
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


.text {
    height: 25px;
}

.percentage {
    background-color: transparent;
    text-align: right;
    height: 20px;
    position: relative;
}

.percentage>div {
    position: relative;
    z-index: 1;
}

.percentage:before {
    content: "";
    background-color: white;
    position: absolute;
    height: 50px;
    width: 155px;
    top: 0;
    left: 0;
    transform: rotate(-27deg);
    z-index: 0;
}

</style>

<g:if test="${lista.size() < 1 && proformas.size() < 1 }">
    <div class="alert alert-warning" style="font-size: 13px">No existe ningún precio del item asignado a un detalle anterior. <strong>Generar un precio mediante una nueva proforma?</strong>
    </div>
</g:if>
<g:else>
    <div style="margin-top: 15px; min-height: 350px" class="vertical-container">
        <p class="css-vertical-text">Resultado - Precios</p>
        <div class="linea"></div>
        <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
            <thead>
            <tr>
                <th class="alinear" style="width: 8%">Precio U.</th>
                <th class="alinear" style="width: 30%">Descripción</th>
                <th class="alinear" style="width: 15%">Proveedor</th>
                <th class="alinear" style="width: 12%">Fuente</th>
                <th class="alinear" style="width: 5%"></th>
                <th class="alinear" style="width: 1%"></th>
            </tr>
            </thead>
        </table>
        <div id="tablaBuscarPrecios">
        </div>
    </div>
</g:else>

<script type="text/javascript">

    cargarTablaBuscarPrecios();

    function cargarTablaBuscarPrecios () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proyecto', action: 'tablaBuscarPrecio_ajax')}',
            data:{
                id: '${proyecto?.id}',
                item: '${item}'
            },
            success: function(msg){
                $("#tablaBuscarPrecios").html(msg)
            }
        });
    }
</script>