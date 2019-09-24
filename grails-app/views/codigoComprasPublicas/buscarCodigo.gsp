<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 09/09/19
  Time: 14:52
--%>

<div style="min-height: 60px" class="vertical-container">
    <p class="css-vertical-text"></p>

    <div class="linea"></div>

    <div>
        <div class="col-md-12">
            <label>Código</label>
            <div class="btn-group">
                <input id="buscarCodigo" type="search" class="form-control">
            </div>
            <label>Descripción</label>
            <div class="btn-group">
                <input id="buscarNombre" type="search" class="form-control">
            </div>
            <div class="btn-group">
                <a href="#" name="busqueda" class="btn btn-success btnBusqueda btn-ajax"><i
                        class="fas fa-search"></i> Buscar</a>
                <a href="#" name="lB" class="limpiaBuscar btn btn-info"><i class="fa fa-eraser"></i> Limpiar</a>
            </div>
        </div>
    </div>
</div>

<div style="margin-top: 20px; min-height: 350px" class="vertical-container">
    <p class="css-vertical-text">Resultados</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th style="width: 15%">Código</th>
            <th style="width: 74%">Descripción</th>
            <th style="width: 11%; text-align: center"><i class="fa fa-check"></i></th>
        </tr>
        </thead>
    </table>

    <div id="tablaCodigos">
    </div>
</div>

<div style="color: #a32713; font-size: 12px; margin-left: 25px">* Máxima cantidad de registros en pantalla 100</div>

<script type="text/javascript">

    $(".limpiaBuscar").click(function () {
        $("#buscarCodigo").val('');
        $("#buscarNombre").val('');
        cargarTablaCodigos();
    });

    $(".btnBusqueda").click(function () {
        cargarTablaCodigos();
    });

    function cargarTablaCodigos() {
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'codigoComprasPublicas', action: 'tablaCodigosCompras')}",
            data:{
                codigo: $("#buscarCodigo").val(),
                nombre: $("#buscarNombre").val()
            },
            success: function (msg) {
                $("#tablaCodigos").html(msg);
                dialog.modal('hide');
            }
        });
    }
</script>