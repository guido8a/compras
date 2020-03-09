<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 12:41
--%>

%{--<!DOCTYPE html>--}%
%{--<html>--}%
%{--<head>--}%
%{--    <meta name="layout" content="main">--}%
%{--    <title>Proformas</title>--}%

%{--    <style type="text/css">--}%

%{--    .alinear {--}%
%{--        text-align: center !important;--}%
%{--    }--}%

%{--    #buscar {--}%
%{--        width: 400px;--}%
%{--        border-color: #0c6cc2;--}%
%{--    }--}%
%{--    </style>--}%

%{--</head>--}%

%{--<body>--}%

%{--<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>--}%

<!-- botones -->
%{--
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="parametros" action="list" class="btn btn-info">
            <i class="fa fa-arrow-left"></i> Parámetros
        </g:link>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-primary btnCrear">
            <i class="fa fa-file"></i> Nueva Proforma
        </a>
    </div>
</div>
--}%

<div style="min-height: 60px; margin-top: 10px" class="vertical-container">
    <p class="css-vertical-text"></p>

    <div class="linea"></div>

    <div>
        <div class="col-md-12">
            <div class="btn-group col-md-4">
                <label>Proveedor</label>
                <g:select name='proveedorBus' from="${compras.Proveedor.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" noSelection="${['' : 'Todos los proveedores']}" class="form-control"/>
            </div>
            <div class="btn-group col-md-4">
                <label>Descripción</label>
                <g:textField name="descripcionBus" id="descripcionBus" type="search" class="form-control"/>
            </div>
            <div class="btn-group col-md-2">
                <label>Fecha desde</label>
                <input name="fechaBus" type='text' id="fechaBus" class="datetimepicker1 form-control" value="${new Date().format("dd-MM-yyyy") - 1}"/>
            </div>
            <div class="btn-group col-md-2" style="margin-top: 17px">
                <a href="#" name="busqueda" class="btn btn-success btnBusquedaBus btn-ajax" title="Buscar proforma"><i class="fa fa-search"></i> </a>
                <a href="#" name="lb" class="limpiaBuscarBus btn btn-warning" title="Limpiar campos de búsqueda"><i class="fa fa-eraser"></i></a>
            </div>

        </div>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Proformas</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 40%">Proveedor</th>
            <th class="alinear" style="width: 45%">Descripción</th>
            <th class="alinear" style="width: 10%">Fecha</th>
            <th class="alinear" style="width: 5%"></th>
        </tr>
        </thead>
    </table>

    <div id="tablaProforma">
    </div>
</div>

<script type="text/javascript">

    $(".limpiaBuscarBus").click(function () {
        $("#proveedorBus").val('');
        $("#descripcionBus").val('');
        cargarTablaProformas();
    });

    $(".btnBusquedaBus").click(function () {
        cargarTablaProformas();
    });

    $('.datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        // daysOfWeekDisabled: [0, 6],
        // inline: true,
        // sideBySide: true,
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });

    %{--$(".btnCrear").click(function () {--}%
    %{--    location.href="${createLink(controller: 'proforma', action: 'proforma')}?tipo=" + 0--}%
    %{--});--}%

    cargarTablaProformas();

    function cargarTablaProformas(){
        var proveedor = $("#proveedorBus option:selected").val();
        var descripcion = $("#descripcionBus").val();
        var fecha = $("#fechaBus").val();
        var proyecto = '${proyecto?.id}'
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proforma', action: 'tablaProforma')}',
            data:{
                proveedor: proveedor,
                descripcion: descripcion,
                fecha: fecha,
                proyecto: proyecto
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#tablaProforma").html(msg)
            }
        });
    }

    %{--function createContextMenu(node) {--}%
    %{--    var $tr = $(node);--}%
    %{--    var items = {--}%
    %{--        header: {--}%
    %{--            label: "Acciones",--}%
    %{--            header: true--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var id = $tr.data("id");--}%

    %{--    var editar = {--}%
    %{--        label: 'Editar',--}%
    %{--        icon: "fa fa-pen text-info",--}%
    %{--        action : function () {--}%
    %{--            location.href="${createLink(controller: 'proforma', action: 'proforma')}?id=" + id + "&tipo=" + 0--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var borrarProforma = {--}%
    %{--        label            : "Borrar",--}%
    %{--        icon             : "fa fa-trash text-danger",--}%
    %{--        separator_before : true,--}%
    %{--        action           : function () {--}%

    %{--        }--}%
    %{--    };--}%

    %{--    items.editar = editar;--}%
    %{--    items.borrar = borrarProforma;--}%

    %{--    return items--}%
    %{--}--}%
</script>

%{--</body>--}%
%{--</html>--}%
