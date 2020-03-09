<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/11/19
  Time: 15:12
--%>


<div style="min-height: 60px" class="vertical-container">
    <p class="css-vertical-text"></p>

    <div class="linea"></div>

    <div>
        <div class="col-md-12">
%{--            <div class="col-md-3">--}%
%{--                <label>Buscar por</label>--}%
%{--                <g:select name="tipo" from="${['1': 'Código', '2' :'Descripción', '3': 'Tipo de proyecto', '4': 'Comunidad', '5': 'Unidad Requirente']}" class="form-control" optionKey="key" optionValue="value" noSelection="${['': 'Seleccione...']}"/>--}%
%{--            </div>--}%
            <div class="btn-group col-md-3">
                <label>Código</label>
                <g:textField name="codigoB" type="search" class="form-control"/>
            </div>
            <div class="btn-group col-md-6">
                <label>Descripción</label>
                <g:textField name="descripcionB" type="search" class="form-control"/>
            </div>
            <div class="btn-group" style="margin-top: 17px">
                <a href="#" class="btn btn-success btnBusqueda btn-ajax" title="Buscar proveedor"><i class="fa fa-search"></i> Buscar</a>
                <a href="#" class="btn btn-warning btnLimpiar" title="Limpiar campos de búsqueda"><i class="fa fa-eraser"></i> Limpiar</a>
            </div>
        </div>
    </div>
</div>


<div style="margin-top: 30px; min-height: 460px" class="vertical-container">
    <p class="css-vertical-text">Resultado - Items</p>
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear"  style="width: 25%">Código</th>
            <th class="alinear"  style="width: 54%">Descripción</th>
            <th class="alinear"  style="width: 15%">Unidad</th>
            <th class="alinear" style="width: 7%"></th>
        </tr>
        </thead>
    </table>

    <div id="tablaItem">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna como máximo 20 <span class="text-info" style="margin-left: 40px">Se ordena por la descripción del item</span>
</div>


<script type="text/javascript">

    cargarBandeja();

    $(".btnLimpiar").click(function () {
        $("#criterio").val('');
        $("#tipo").val('');
        cargarBandeja();
    });

    $(".btnBusqueda").click(function () {
        cargarBandeja();
    });

    function cargarBandeja(){
        $("#tablaItem").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        var codigo = $("#codigoB").val();
        var descripcion = $("#descripcionB").val();
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'proyecto', action: 'tablaItem')}",
            data    : {
                codigo: codigo,
                descripcion: descripcion
            },
            success : function (msg) {
                dialog.modal('hide');
                $("#tablaItem").html(msg);
            },
            error   : function (msg) {
                dialog.modal('hide');
                $("#tablaItem").html("Ha ocurrido un error");
            }
        });
    }

</script>
