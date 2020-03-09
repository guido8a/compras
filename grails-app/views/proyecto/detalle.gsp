<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/11/19
  Time: 10:44
--%>


<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Detalle del proyecto</title>

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

    .bordeColor2 {
        border-width: 2px;
        border-style: solid;
        border-color: #e1a628;
        /*padding: 5px;*/
    }

    .hidden{
        visibility:hidden;
    }

    </style>

</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 20px;">
    <div class="btn-group">
        <a href="#" class="btn btn-primary btnRegresar"><i class="fa fa-arrow-left"></i> Proyecto</a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-success btnImprimirProcesos"><i class="fa fa-print"></i> Imprimir Procesos</a>
        <a href="#" class="btn btn-info btnImprimirProformas"><i class="fa fa-print"></i> Imprimir Proformas</a>
        <a href="#" class="btn btn-primary btnImprimirPresupuesto"><i class="fa fa-print"></i> Imprimir Presupuesto Referencial</a>
    </div>
</div>

<div class="row" style="font-size: 12px; margin-bottom: 20px">
    <div class="col-md-1"></div>
    <div class="col-md-1">
        <label style="color: #5596ff;"> Proyecto:  </label>
    </div>
    <div class="col-md-9">
        <strong class="alert alert-info" title="${proyecto?.nombre}"> ${proyecto?.nombre} </strong>
    </div>
</div>

<div style="min-height: 70px" class="vertical-container divEditar">
    <p class="css-vertical-text">Item</p>
    <div class="linea"></div>

    <g:form class="form-horizontal" name="frmDetalle" controller="detalleProyecto" action="agregarItem_ajax">
        <g:hiddenField name="proyecto" value="${proyecto?.id}"/>
        <g:hiddenField name="detalle"/>

        <div>
            <div class="col-md-12" style="margin-bottom: 10px">
                <div class="btn-group col-md-2">
                    <label>Código</label>
                    <g:hiddenField name="item" />
                    <g:textField name="codigo" type="search" class="form-control" readonly=""/>
                </div>
                <div class="btn-group col-md-6">
                    <label>Descripción</label>
                    <g:textField name="nombre"  type="search" class="form-control" readonly=""/>
                </div>
                <div class="btn-group col-md-1" style="margin-top: 17px">
                    <a href="#" name="busqueda" class="btn btn-info btnBusqueda btn-ajax" title="Buscar item"><i class="fa fa-search"></i> </a>
                </div>
                <div class="btn-group col-md-1">
                    <label>Cantidad</label>
                    <g:textField name="cantidad"  type="search" class="form-control"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
                <div class="btn-group col-md-1">
                    <label>Orden</label>
                    <g:textField name="orden"  type="search" class="form-control"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>

                <g:if test="${proyecto?.estado != 'R'}">
                    <div class="btn-group" style="margin-top: 20px">
                        <a href="#" name="agregar" class="btnAgregar btn btn-success" title="Agregar item"><i class="fa fa-level-down-alt"></i> </a>
                    </div>
                    <div class="btn-group" style="margin-top: 20px">
                        <a href="#" name="guardar" class="btnGuardar btn btn-success hidden" title="Guardar"><i class="fa fa-save"></i> </a>
                    </div>
                    <div class="btn-group" style="margin-top: 20px">
                        <a href="#" name="cancelar" class="btnCancelar btn btn-warning hidden" title="Cancelar edición"><i class="fa fa-window-close"></i></a>
                    </div>
                </g:if>
            </div>

            %{--            <div class="col-md-12">--}%

            %{--                <div class="btn-group col-md-2">--}%
            %{--                    <label>Origen del precio</label>--}%
            %{--                    <g:hiddenField name="origen"/>--}%
            %{--                    <g:textField name="origen_name"  type="search" class="form-control" disabled=""/>--}%
            %{--                    <p class="help-block ui-helper-hidden"></p>--}%
            %{--                </div>--}%
            %{--                <div class="btn-group col-md-2">--}%
            %{--                    <label>Precio Unitario</label>--}%
            %{--                    <g:textField name="precioUnitario"  type="search" class="form-control" disabled=""/>--}%
            %{--                </div>--}%
            %{--                <div class="btn-group col-md-1" style="margin-top: 20px">--}%
            %{--                    <a href="#" name="cancelar" class="btnBuscarPrecio btn btn-warning" title="Buscar Precio"><i class="fa fa-search"></i></a>--}%
            %{--                </div>--}%
            %{--                <div class="btn-group" style="margin-top: 20px">--}%
            %{--                    <a href="#" name="agregar" class="btnAgregar btn btn-success" title="Agregar item"><i class="fa fa-level-down-alt"></i> Agregar</a>--}%
            %{--                </div>--}%
            %{--                <div class="btn-group" style="margin-top: 20px">--}%
            %{--                    <a href="#" name="guardar" class="btnGuardar btn btn-success hidden" title="Agregar item"><i class="fa fa-save"></i> Guardar</a>--}%
            %{--                </div>--}%
            %{--                <div class="btn-group" style="margin-top: 20px">--}%
            %{--                    <a href="#" name="cancelar" class="btnCancelar btn btn-warning hidden" title="Cancelar edición"><i class="fa fa-window-close"></i></a>--}%
            %{--                </div>--}%
            %{--            </div>--}%
        </div>
    </g:form>
</div>

<div style="min-height: 70px; margin-top: 5px" class="vertical-container divEditarPrecio">
    <p class="css-vertical-text">Precios</p>
    <div class="linea"></div>
    %{--    <g:form class="form-horizontal" name="" controller="" action="">--}%
    <div class="col-md-12">
        <div class="btn-group col-md-2">
            <label>Origen del precio</label>
            <g:hiddenField name="origen"/>
            <g:hiddenField name="idOrigen"/>
            <g:textField name="origen_name"  type="search" class="form-control" disabled=""/>
            <p class="help-block ui-helper-hidden"></p>
        </div>
        <div class="btn-group col-md-2">
            <label>Precio Unitario</label>
            <g:textField name="precioUnitario"  type="search" class="form-control" disabled=""/>
        </div>
        <g:if test="${proyecto?.estado != 'R'}">
            <div class="btn-group col-md-1" style="margin-top: 20px">
                <a href="#" name="cancelar" class="btnBuscarPrecio btn btn-warning hidden" title="Buscar Precio"><i class="fa fa-search"></i></a>
            </div>
            <div class="btn-group" style="margin-top: 20px">
                <a href="#" name="agregarP" class="btnAgregarPrecio btn btn-success hidden" title="Agregar precio"><i class="fa fa-level-down-alt"></i> Agregar precio</a>
            </div>
            <div class="btn-group" style="margin-top: 20px">
                <a href="#" name="guardarP" class="btnGuardarPrecio btn btn-success hidden" title="Guardar precio"><i class="fa fa-save"></i> Guardar</a>
            </div>
            <div class="btn-group" style="margin-top: 20px">
                <a href="#" name="cancelarP" class="btnCancelarPrecio btn btn-warning hidden" title="Cancelar"><i class="fa fa-window-close"></i></a>
            </div>
        </g:if>
    </div>
    %{--    </g:form>--}%
</div>

<div style="margin-top: 15px; min-height: 480px" class="vertical-container">
    <p class="css-vertical-text">Resultado - Detalle del proyecto</p>
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 5%">Orden</th>
            <th class="alinear"  style="width: 7%">Código</th>
            <th class="alinear"  style="width: 36%">Descripción</th>
            <th class="alinear" style="width: 23%">Lista de Precios</th>
            <th class="alinear" style="width: 8%">Precio U.</th>
            <th class="alinear"  style="width: 6%">Cantidad</th>
            <th class="alinear" style="width: 7%">Subtotal</th>
            <th class="alinear" style="width: 8%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="tablaDetalle">
    </div>
</div>

<div class="col-md-8"><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna como máximo 20 <span class="text-info" style="margin-left: 40px">Se ordena por orden del detalle.</span>
</div>

<script type="text/javascript">


    $(".btnImprimirProcesos").click(function () {
        var id = '${proyecto?.id}';
        location.href = "${createLink(controller: 'reportes', action: 'reporteProcesos')}?id=" + id;
    });

    $(".btnImprimirProformas").click(function () {
        var id = '${proyecto?.id}';
        location.href = "${createLink(controller: 'reportes', action: 'reporteProformas')}?id=" + id;
    });

    $(".btnImprimirPresupuesto").click(function () {
        var id = '${proyecto?.id}';
        location.href = "${createLink(controller: 'reportes', action: 'reportePresupuesto')}?id=" + id;
    });

    %{--function revisarPrecioEnUso(detalle){--}%
    %{--    $.ajax({--}%
    %{--        type: 'POST',--}%
    %{--        url: "${createLink(controller: 'precio', action: 'revisarUso_ajax')}",--}%
    %{--        data:{--}%
    %{--            id: detalle--}%
    %{--        },--}%
    %{--        success: function (msg){--}%
    %{--            return msg--}%
    %{--        }--}%
    %{--    });--}%
    %{--}--}%

    $(".btnBuscarPrecio").click(function () {
        var item = $("#item").val();
        if(item == ''){
            mensajeError("Seleccione un item!")
        }else{
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'proyecto', action:'buscarPrecio')}",
                data    : {
                    item:item,
                    id: '${proyecto?.id}'
                },
                success : function (msg) {
                    bootbox.dialog({
                        id    : 'dlgBuscarPrecio',
                        title : "Buscar precio",
                        class : "modal-lg",
                        message : msg,
                        buttons : {
                            proforma : {
                                label     : "<i class='fa fa-file'></i> Nueva Proforma",
                                className : "btn-warning",
                                callback  : function () {
                                    location.href="${createLink(controller: 'proforma', action: 'proforma')}?tipo=" + 1 + "&proyecto=" + '${proyecto?.id}';
                                }
                            },
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
        }
    });

    $(".btnRegresar").click(function () {
        var id = '${proyecto?.id}';
        location.href="${createLink(controller: 'proyecto', action: 'registroProyecto')}?id=" + id
    });

    $(".btnBusqueda").click(function () {

        var band = false
        var detalle = $("#detalle").val();

        if(detalle != ''){
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'precio', action: 'revisarExistentes_ajax')}',
                data:{
                    detalle: detalle
                },
                success: function (msg){
                    if(msg == 'ok'){
                        buscarItem();
                    }else{
                        mensajeError("Ya existen precios asignados a este item, no es posible cambiarlo")
                    }
                }
            })
        }else{
            buscarItem();
        }
    });

    function buscarItem(){
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
    }

    function submitFormDetalle() {
        var $form = $("#frmDetalle");
        var id = '${proyecto?.id}';
        $("#precioUnitario").attr("disabled", false);
        var data = $form.serialize();
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type    : "POST",
            url     : $form.attr("action"),
            data    : data,
            success : function (msg) {
                $("#precioUnitario").attr("disabled", true);
                dialog.modal('hide');
                var parts = msg.split("_");
                if(parts[0] == 'ok'){
                    log("Item agregado al detalle correctamente", "success");
                    setTimeout(function () {
                        $(".btnCancelar").addClass("hidden");
                        $(".tabla tr").removeClass("recolor");
                        $(".divEditar").removeClass("bordeColor");
                        $(".btnAgregar").removeClass("hidden");
                        $(".btnGuardar").addClass("hidden");
                        limpiarCampos();
                        cargarTablaDetalle(id)
                    }, 1000);
                }else{
                    if(parts[0] == 'er'){
                        mensajeError(parts[1])
                    }else{
                        log("Error al agregar el item al detalle","error");
                        return false;
                    }
                }
            }
        });
    }

    $(".btnAgregar, .btnGuardar").click(function () {
        if($("#item").val() == ''){
            mensajeError("Seleccione un item")
        }else{
            if($("#cantidad").val() == ''){
                mensajeError("Ingrese una cantidad")
            }else{
                // if($("#precioUnitario").val() == ''){
                //     mensajeError("Ingrese un precio")
                // }else{
                if($("#orden").val() == ''){
                    mensajeError("Ingrese un orden")
                }else{
                    var ordenIngresado = $("#orden").val();
                    var detalle = $("#detalle").val();
                    $.ajax({
                        type: 'POST',
                        url: "${createLink(controller: 'detalleProyecto', action: 'revisarOrden_ajax')}",
                        data:{
                            orden: ordenIngresado,
                            detalle: detalle,
                            proyecto: '${proyecto?.id}'
                        },
                        success:function (msg){
                            if(msg == 'ok'){
                                submitFormDetalle();
                            }else{
                                mensajeError("El orden ingresado ya se encuentra asignado!")
                            }
                        }
                    });
                }
                // }
            }
        }
    });

    function mensajeError(mensaje){
        return  bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 13px">' + mensaje + '</strong>');
    }

    cargarTablaDetalle('${proyecto?.id}');

    function cargarTablaDetalle (id) {
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'detalleProyecto', action: 'tablaDetalle')}',
            data:{
                id: id
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#tablaDetalle").html(msg)
            }
        });
    }

    $(".btnAgregarPrecio").click(function () {
        var precioOrigen = $("#precioUnitario").val();
        var origen = $("#origen").val();
        var idPrecio = $("#idOrigen").val();
        var idDetalle = $("#detalle").val();

        if(precioOrigen == ''){
            mensajeError("Seleccione un precio")
        }else{
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'precio', action: 'agregarPrecio_ajax')}",
                data:{
                    origen: origen,
                    idPrecio: idPrecio,
                    precio: precioOrigen,
                    idDetalle: idDetalle
                },
                success: function (msg){
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        $("#origen_name").val('');
                        $("#origen").val('');-
                            $("#idOrigen").val('');
                        $("#precioUnitario").val('');
                        log("Precio agregado correctamente","success");
                        cargarTablaProforma(idDetalle);
                        cargarTablaDetalleDet(idDetalle);
                        limpiarPrecioUnitario(idDetalle);

                        if(origen == 'P'){
                            limpiarPrecioProforma(idDetalle)
                        }else{
                            limpiarPrecioDetalle(idDetalle)
                        }
                    }else{
                        if(parts[0] == 'er' || parts[0] == 'my'){
                            mensajeError(parts[1])
                        }else{
                            log("Error al agregar el precio","error")
                        }
                    }
                }
            });
        }
    });

    function limpiarCampos () {
        $("#item").val('');
        $("#detalle").val('');
        $("#codigo").val('');
        $("#nombre").val('');
        $("#orden").val('');
        $("#precioUnitario").val('');
        $("#cantidad").val('');
        $("#origen_name").val('');
        $("#origen").val('');
    }

    $(".btnCancelar").click(function () {
        $(this).addClass("hidden");
        $(".tabla tr").removeClass("recolor");
        $(".divEditar").removeClass("bordeColor");
        $(".btnAgregar").removeClass("hidden");
        $(".btnGuardar").addClass("hidden");
        limpiarCampos();
    });

    $(".btnCancelarPrecio").click(function () {
        $(this).addClass("hidden");
        $(".tabla tr").removeClass("precioColor");
        $(".divEditarPrecio").removeClass("bordeColor2");
        $(".btnBuscarPrecio").addClass("hidden");
        $(".btnAgregarPrecio").addClass("hidden");
        $(".btnGuardarPrecio").addClass("hidden");
        $(".btnAgregar").removeClass("hidden");
        $(".btnGuardar").addClass("hidden");
        $(".btnBusqueda").removeClass("hidden");
        limpiarCampos();
    });

    $("#precioUnitario").keydown(function (ev) {
        return validarNumeroDecimal(ev)
    });

    $("#cantidad, #orden").keydown(function (ev) {
        return validarNumero(ev)
    });

    function validarNumero(ev) {
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
            ev.keyCode == 37 || ev.keyCode == 39);
    }

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

    // var validator = $("#frmDetalle").validate({
    //     errorClass     : "help-block",
    //     errorPlacement : function (error, element) {
    //         if (element.parent().hasClass("input-group")) {
    //             error.insertAfter(element.parent());
    //         } else {
    //             error.insertAfter(element);
    //         }
    //         element.parents(".grupo").addClass('has-error');
    //     },
    //     success        : function (label) {
    //         label.parents(".grupo").removeClass('has-error');
    //     }
    // });


</script>

</body>
</html>