<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 14/11/19
  Time: 11:54
--%>

<div style="min-height: 60px" class="vertical-container">
    <p class="css-vertical-text"></p>

    <div class="linea"></div>

    <div>
        <div class="col-md-12">
            <div class="col-md-3">
                <label>Buscar por</label>
                <g:select name="tipo" from="${['1': 'Código', '2' :'Nombre', '3': 'Tipo de proyecto', '4': 'Comunidad', '5': 'Unidad Requirente']}" class="form-control" optionKey="key" optionValue="value" noSelection="${['': 'Seleccione...']}"/>
            </div>
            <div class="btn-group col-md-6">
                <label>Criterio</label>
                <g:textField name="criterio" type="search" class="form-control ct"/>
            </div>
            <div class="btn-group" style="margin-top: 17px">
                <a href="#" class="btn btn-success btnBusqueda btn-ajax" title="Buscar proveedor"><i class="fa fa-search"></i> Buscar</a>
                <a href="#" class="btn btn-warning btnLimpiar" title="Limpiar campos de búsqueda"><i class="fa fa-eraser"></i> Limpiar</a>
            </div>
        </div>
    </div>
</div>


<div style="margin-top: 30px; min-height: 460px" class="vertical-container">
    <p class="css-vertical-text">Resultado - Proyectos</p>
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear"  style="width: 10%">Código</th>
            <th class="alinear"  style="width: 40%">Proyecto</th>
            <th class="alinear"  style="width: 15%">Tipo Adq.</th>
            <th class="alinear" style="width: 15%">Tipo de proyecto</th>
            <th class="alinear" style="width: 15%">Comunidad</th>
            <th class="alinear" style="width: 5%"></th>
            %{--            <th class="alinear" style="width: 2%"></th>--}%
        </tr>
        </thead>
    </table>

    <div id="tablaProyecto">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna como máximo 20 <span class="text-info" style="margin-left: 40px">Se ordena por nombre del proyecto</span>
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
        $("#tablaProyecto").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        var tipo = $("#tipo").val();
        var criterio = $("#criterio").val();
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'proyecto', action: 'tablaProyecto')}",
            data    : {
                tipo: tipo,
                criterio: criterio
            },
            success : function (msg) {
                dialog.modal('hide');
                $("#tablaProyecto").html(msg);
            },
            error   : function (msg) {
                dialog.modal('hide');
                $("#tablaProyecto").html("Ha ocurrido un error");
            }
        });
    }


</script>
