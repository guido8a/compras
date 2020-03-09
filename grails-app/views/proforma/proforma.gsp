<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 09/12/19
  Time: 10:55
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Proforma </title>

    <style type="text/css">

    .alinear {
        text-align : center !important;
    }

    .bordeColor {
        border-width: 2px;
        border-style: solid;
        border-color: #5596ff;
        /*padding: 5px;*/
    }

    .hidden{
        visibility:hidden;
    }

    </style>

</head>

<body>
<div class="btn-toolbar toolbar" style="margin-bottom: 20px">
    <g:if test="${proyecto?.id}">
        <div class="btn-group">
            <a href="#" class="btn btn-info btnRegresar"><i class="fa fa-arrow-left"></i> Detalle</a>
        </div>
    </g:if>
    <div class="btn-group">
        <a href="#" class="form-control btn btn-primary btnListarProformas"><i class="fa fa-list"></i> Lista de proformas</a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-info btnNuevaProforma" title="nueva proforma"><i class="fa fa-file"></i> Nueva proforma</a>
    </div>
    <g:if test="${proforma?.id}">
        <div class="btn-group">
            <a href="#" class="btn btn-warning btnRegistrar">
                <g:if test="${proforma?.estado != 'R'}">
                    <i class="fa fa-check"></i> Registrar
                </g:if>
                <g:else>
                    <i class="fa fa-times-circle"></i> Quitar Registro
                </g:else>
            </a>
        </div>
    </g:if>
    <g:if test="${proforma?.estado != 'R'}">
        <div class="btn-group">
            <a href="#" class="btn btn-success ${proyecto?.id ? 'btnGuardarProforma' : 'btnGuardarProforma2'}" title="Guardar proforma"><i class="fa fa-save"></i> Guardar</a>
        </div>
        <g:if test="${proforma?.id}">
            <a href="#" class="btn btn-danger btnBorrarProforma" data-id="${proforma?.id}" title="Borrar proforma"><i class="fa fa-trash"></i> Borrar</a>
        </g:if>
    </g:if>
</div>

<div style="min-height: 200px" class="vertical-container divEditar">
    <p class="css-vertical-text">Datos Proforma</p>
    <div class="linea"></div>

    <g:form class="form-horizontal" name="frmProforma" action="guardarProforma_ajax">
        <g:hiddenField name="proyecto" value="${proyecto?.id}"/>
        <g:hiddenField name="tipo" value="${tipo}"/>
        <g:hiddenField name="id" value="${proforma?.id}"/>
        <div>
            <div class="col-md-12" style="margin-bottom: 10px">
                <div class="btn-group col-md-6">
                    <label>Proveedor</label>
                    <g:select name="proveedor" from="${compras.Proveedor.list().sort{it.nombre}}" class="form-control" optionKey="id" optionValue="nombre" value="${proforma?.proveedor?.id}"/>
                </div>
                <div class="btn-group col-md-2">
                    <label>Fecha</label>
                    <input name="fecha" type='text' class="datetimepicker1 form-control" value="${proforma?.fecha?.format("dd-MM-yyyy") ?: new Date().format("dd-MM-yyyy")}"/>
                </div>
                <div class="btn-group col-md-3" style="margin-top: 18px">
                    <g:textField name="estado" class='form-control' style="background-color: ${proforma?.estado == 'R' ? '#47b636' : '#e1a628'}; text-align: center; font-weight: bold" disabled="" title="${proforma?.estado == 'R' ? 'Registrado' : 'No registrado'}" value="${proforma?.estado == 'R' ? 'Registrado' : 'No Registrado'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>

            <div class="col-md-12" style="margin-bottom: 10px">
                <span class="grupo">
                    <div class="col-md-7">
                        <label>Descripción</label>
                        <g:textField name="descripcion" maxlength="255" class="form-control required" value="${proforma?.descripcion}"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <div class="btn-group col-md-2">
                    <label>Plazo</label>
                    <g:textField name="plazo"  type="search" maxlength="3" class="form-control digits" value="${proforma?.plazo}"/>
                </div>
                <div class="btn-group col-md-3">
                    <label>Calificación</label>
                    <g:textField name="calificacion"  type="search" maxlength="40" class="form-control" value="${proforma?.calificacion}"/>
                </div>
            </div>
            <div class="col-md-12" style="margin-bottom: 10px">
                <div class="btn-group col-md-12">
                    <label>Observaciones</label>
                    <g:textField name="observaciones" type="search"  maxlength="127" class="form-control" style="resize: none" value="${proforma?.observaciones}"/>
                </div>
            </div>
        </div>
    </g:form>
</div>

<g:if test="${proforma?.id}">
    <div style="min-height: 75px; margin-top: 5px" class="vertical-container divEditar">
        <p class="css-vertical-text">Item</p>
        <div class="linea"></div>
        <div class="col-md-12" style="margin-bottom: 10px">
            <div class="btn-group col-md-2">
                <label>Código</label>
                <g:hiddenField name="item" />
                <g:textField name="codigo" type="search" class="form-control" readonly=""/>
            </div>
            <div class="btn-group col-md-4">
                <label>Descripción</label>
                <g:textField name="nombre"  type="search" class="form-control" readonly="" />
            </div>
            <div class="btn-group col-md-1" style="margin-top: 18px">
                <a href="#" name="busqueda" class="btn btn-info btnBusqueda btn-ajax" title="Buscar proveedor"><i class="fa fa-search"></i></a>
            </div>
            <div class="btn-group col-md-2">
                <label>Precio</label>
                <g:textField name="precio" type="search" class="form-control" />
            </div>
            <div class="btn-group col-md-2">
                <label>Procedencia</label>
                <g:select name="procedencia" from="${['N' : 'NACIONAL', 'I' : 'EXTRANJERO']}" optionValue="value" optionKey="key" class="form-control"/>
            </div>
            <g:if test="${proforma?.estado != 'R'}">
                <div class="btn-group col-md-1" style="margin-top: 18px">
                    <a href="#" name="busqueda" class="btn btn-success btnAgregar btn-ajax" title="Buscar proveedor"><i class="fa fa-plus"></i> Agregar</a>
                </div>
            </g:if>
        </div>
    </div>

    <div style="margin-top: 15px; min-height: 300px" class="vertical-container">
        <p class="css-vertical-text">Items en la proforma</p>
        <div class="linea"></div>
        <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
            <thead>
            <tr>
                <th class="alinear"  style="width: 15%">Código</th>
                <th class="alinear"  style="width: 45%">Descripción</th>
                <th class="alinear" style="width: 15%">Precio U.</th>
                <th class="alinear" style="width: 15%">Procedencia</th>
                <th class="alinear" style="width: 5%"></th>
            </tr>
            </thead>
        </table>
        <div id="tablaDetalleProforma">
        </div>
    </div>
</g:if>

<script type="text/javascript">

    $(".btnBorrarProforma").click(function () {
        var id = $(this).data("id");
        borrarProforma(id);
    });

    function borrarProforma (id) {
        bootbox.confirm({
            title: "Borrar",
            message: "Está seguro de borrar esta proforma? Esta acción no puede deshacerse.",
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
                        url: '${createLink(controller: 'proforma', action: 'borrarProforma_ajax')}',
                        data:{
                            id: id
                        },
                        success: function (msg) {
                            dialog.modal('hide');
                            var parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                log("Proforma borrada correctamente","success");
                                setTimeout(function () {
                                    cargarTablaProformas();
                                }, 1000);
                            }else{
                                if(parts[0] == 'er'){
                                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                }else{
                                    log("Error al borrar la proforma", "error")
                                }
                            }
                        }
                    });
                }
            }
        });
    }

    $(".btnListarProformas").click(function () {
        var proyecto = '${proyecto?.id}';
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'proforma', action:'list')}",
            data    : {
                proyecto: proyecto
            },
            success : function (msg) {
                bootbox.dialog({
                    id    : 'dlgBuscarProforma',
                    title : "Buscar Proforma",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    if('${proforma?.id}'){
        $(".btnAgregar").click(function () {
            if($("#item").val() == ''){
                mensajeError("Seleccione un item!")
            }else{
                if($("#precio").val() == ''){
                    mensajeError("Ingrese un precio!")
                }else{
                    var item = $("#item").val();
                    var proforma = '${proforma?.id}';
                    var precio = $("#precio").val();
                    var pro = $("#procedencia option:selected").val();
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'detalleProforma', action: 'agregarDetallePrecio_ajax')}',
                        data:{
                            item: item,
                            proforma: proforma,
                            precioUnitario: precio,
                            procedencia: pro
                        },
                        success: function (msg){
                            var  parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                log("Item agregado correctamente","success");
                                cargarTablaDetalles(proforma)
                                limpiarCampos();
                            }else{
                                if(parts[0] == 'me'){
                                    mensajeError(parts[1]);
                                }else{
                                    log("Error al agregar el item","error")
                                }
                            }
                        }
                    })
                }
            }
        });

        cargarTablaDetalles('${proforma?.id}');

        function cargarTablaDetalles (proforma) {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'detalleProforma', action: 'tablaDetalleProforma')}',
                data:{
                    proforma: proforma
                } ,
                success: function (msg) {
                    $("#tablaDetalleProforma").html(msg)
                }
            });
        }
    }

    function limpiarCampos(){
        $("#item").val('');
        $("#codigo").val('');
        $("#nombre").val('');
        $("#precio").val('');
        $("#procedencia").val('N')
    }

    $(".btnBusqueda").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'proyecto', action:'buscarItem')}",
            data    : { },
            success : function (msg) {
                bootbox.dialog({
                    id    : 'dlgBuscarItem',
                    title : "Buscar Item",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    $(".btnRegistrar").click(function () {
        bootbox.confirm({
            title: "Cambiar estado a la proforma",
            message: "<i class='fa fa-exclamation-triangle text-warning fa-3x'></i> Está seguro de cambiar el estado a esta proforma?.",
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> Cancelar',
                    className: 'btn-primary'
                },
                confirm: {
                    label: '<i class="fa fa-save"></i> Aceptar',
                    className: 'btn-success'
                }
            },
            callback: function (result) {
                if(result){
                    var dialog = cargarLoader("Guardando...");
                    $.ajax({
                        type: 'POST',
                        url:'${createLink(controller: 'proforma', action: 'cambiarEstado_ajax')}',
                        data:{
                            id: '${proforma?.id}'
                        },
                        success:function (msg){
                            if(msg == 'ok'){
                                if(${tipo == 1}){
                                    location.href="${createLink(controller: 'proforma', action: 'proforma')}?proyecto=" + '${proyecto?.id}' + "&id=" + '${proforma?.id}' + "&tipo=" + 1
                                }else{
                                    location.href="${createLink(controller: 'proforma', action: 'proforma')}?id=" + '${proforma?.id}' + "&tipo=" + 0
                                }
                            }else{
                                dialog.modal('hide');
                                log("Error al cambiar el estado de la proforma","error");
                            }
                        }
                    });
                }
            }
        });
    });

    $(".btnNuevaProforma").click(function () {
        %{--if(${tipo == 1}){--}%
        location.href="${createLink(controller: 'proforma', action: 'proforma')}?proyecto=" + '${proyecto?.id}' + "&tipo=" + 1
        // }else{
        %{--    location.href="${createLink(controller: 'proforma', action: 'proforma')}"--}%
        // }
    });

    $(".btnGuardarProforma").click(function () {
        submitFormProforma(1);
    });

    $(".btnGuardarProforma2").click(function () {
        submitFormProforma(0);
    });

    function submitFormProforma(tipo) {
        var $form = $("#frmProforma");
        %{--var id = '${proyecto?.id}';--}%
        if ($form.valid()) {
            var data = $form.serialize();
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Proforma guardada correctamente", "success");
                        setTimeout(function () {
                            if(tipo == 1){
                                location.href="${createLink(controller: 'proforma', action: 'proforma')}?tipo=" + 1 +"&proyecto=" + '${proyecto?.id}' + "&id=" + parts[1]
                            }else{
                                location.href="${createLink(controller: 'proforma', action: 'proforma')}?id=" + parts[1] + "&tipo=" + 0
                            }
                        }, 500);
                    }else{
                        log("Error guardar la proforma","error");
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    $(".btnRegresar").click(function () {
        var id = '${proyecto?.id}';
        location.href="${createLink(controller: 'proyecto', action: 'detalle')}?id=" + id
    });

    function mensajeError(mensaje){
        return  bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + mensaje + '</strong>');
    }

    $('.datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        // inline: true,
        // sideBySide: true,
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });

    var validator = $("#frmProforma").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });

    $("#precio").keydown(function (ev) {
        return validarNumeroDecimal(ev)
    });

    function validarNumeroDecimal(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 190 || ev.keyCode == 110);
    }

</script>

</body>
</html>
