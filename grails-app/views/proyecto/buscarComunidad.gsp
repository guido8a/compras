<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 06/11/19
  Time: 14:25
--%>

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
        %{--        <div class="col-md-12">--}%

        <div class="btn-group col-md-3">
            <label>Buscar Por</label>
            <g:select name="n" id='sele' class="form-control" from="${['1':'PROVINCIA', '2':'CANTÓN', '3':'PARROQUIA','4':'COMUNIDAD']}" optionValue="value" optionKey="key"/>
        </div>
        %{--            <div class="btn-group col-md-3" id="divCanton">--}%
        %{--                <label>Cantón</label>--}%
        %{--                <g:select name="canton_n" id='cantonSel' class="form-control" from="${''}" optionValue="nombre" optionKey="id" noSelection="${['null': 'Seleccione...']}"/>--}%
        %{--            </div>--}%
        %{--            <div class="btn-group col-md-3" id="divParr">--}%
        %{--                <label>Parroquia</label>--}%
        %{--                <g:select name="parroquia_n" id='parroquiaSel' class="form-control" from="${''}" optionValue="nombre" optionKey="id" noSelection="${['null': 'Seleccione...']}"/>--}%
        %{--            </div>--}%
        <div class="btn-group col-md-6">
            <label>Criterio</label>
            <g:textField name="bn" id="criterio" class="form-control"/>
        </div>
        <div class="btn-group" style="margin-top: 18px">
            <a href="#" name="busqueda" class="btn btn-success btnBusqueda btn-ajax" title="Buscar"><i class="fas fa-search"></i>Buscar</a>
            <a href="#" name="lB" class="limpiaBuscar btn btn-info" title="Limpiar campos de búsqueda"><i class="fa fa-eraser"></i>Limpiar</a>
        </div>
    </div>
    %{--    </div>--}%
</div>

<div style="margin-top: 20px; height: 350px;" class="vertical-container">
    <p class="css-vertical-text">Resultados</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="background-color: #a39e9e">
        <thead>
        <tr>
            <th style="width: 23%">Provincia</th>
            <th style="width: 22%">Cantón</th>
            <th style="width: 22%">Parroquia</th>
            <th style="width: 24%">Comunidad</th>
            <th style="width: 9%; text-align: center"><i class="fa fa-check"></i></th>
        </tr>
        </thead>
    </table>

    <div id="tablaComunidad">
    </div>
</div>

%{--<div style="color: #a32713; font-size: 12px; margin-left: 25px">* Máxima cantidad de registros en pantalla 100</div>--}%

<script type="text/javascript">


    $(".limpiaBuscar").click(function () {
        $("#buscarCodigo").val('');
        $("#buscarNombre").val('');
        cargarTablaComunidad();
    });

    $(".btnBusqueda").click(function () {
        cargarTablaComunidad();
    });

    function cargarTablaComunidad() {
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proyecto', action: 'tablaComunidad')}",
            data:{
                sele: $("#sele option:selected").val(),
                criterio: $("#criterio").val()
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#tablaComunidad").html(msg);
            }
        });
    }
</script>