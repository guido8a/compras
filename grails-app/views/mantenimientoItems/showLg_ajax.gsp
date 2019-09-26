%{--<div class="tituloTree">Precios de: ${item.nombre} (${item.unidad?.codigo?.trim()}) <br> Lista: ${lugarNombre}</div>--}%

<asset:javascript src="/apli/tableHandlerBody.js"/>




<div class="control-group">
    <table class="table-bordered table-condensed table-hover" width="100%">
        <tr>
            <td style="width: 35%" class="alert-warning">Precios de: </td>
            <td style="width: 65%" class="alert-success">${item.nombre} (${item.unidad?.codigo?.trim()})</td>
        </tr>
    </table>
</div>

<div class="control-group">
    <table class="table-bordered table-condensed table-hover" width="100%">
        <tr>
            <td style="width: 35%" class="alert-warning">Lista: </td>
            <td style="width: 65%" class="alert-success">${lugarNombre}</td>
        </tr>
    </table>
</div>

<div style="height: 35px; width: 100%; margin-top: 5px;">
    <div class="btn-group pull-left" style="">
        %{--        <g:if test="${session.perfil.codigo == 'CSTO'}">--}%


        <a href="#" class="btn btn-info btn-ajax btnNP" id="btnNew">
            <i class="fa fa-money-check-alt"></i>
            Nuevo Precio
        </a>
        %{--            <a href="#" class="btn btn-success btn-ajax" id="btnSave">--}%
        %{--                <i class="fa fa-save"></i>--}%
        %{--                Guardar--}%
        %{--            </a>--}%
        %{--        <g:if test="${item.departamento.subgrupo.grupoId == 2 || item.departamento.subgrupo.grupoId == 3}">--}%
        %{--            <a href="#" class="btn btn-warning btn-ajax" id="btnCalc${item.departamento.subgrupo.grupoId}">--}%
        %{--                <i class="fa fa-money"></i>--}%
        %{--                Calcular precio--}%
        %{--            </a>--}%
        %{--        --}%%{--            </g:if>--}%
        %{--        </g:if>--}%
    </div>

    <g:if test="${item.departamento.subgrupo.grupoId == 2 || item.departamento.subgrupo.grupoId == 3}">
        <span style="margin-left: 10px;" id="spanRef">

        </span>
    </g:if>

    <g:if test="${item.departamento.subgrupo.grupoId == 2 || item.departamento.subgrupo.grupoId == 3}">
        <div class="btn-group pull-left">
            <a href="#" class="btn btn-ajax" id="btnPrint" style="display: none; margin-left: 10px" data-id="${item.id}" data-nombre="${item.nombre}">
                <i class="icon-print"></i>
                Imprimir
            </a>
        </div>
    </g:if>
</div>

<div id="divTabla" style="height: 490px; width: 100%; overflow-x: hidden; overflow-y: auto;">
    <table class="table table-striped table-bordered table-hover table-condensed" id="tablaPrecios">
        <thead>
        <tr>
            <g:if test="${lgar}">
                <th>Lugar</th>
            </g:if>
            <th class="alert-success">Fecha</th>
            <th class="precio alert-success">Precio</th>
            <th class="editar alert-success" style="text-align: center"><i class="fa fa-pen"></i></th>
            <th class="registrar alert-info" style="text-align: center"><i class="fa fa-registered"></i></th>
            <th class="delete alert-danger" style="text-align: center"><i class="fa fa-trash"></i></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${precios}" var="precio" status="i">
            <tr>
                <g:if test="${lgar}">
                    <td>
                        ${precio.lugar.descripcion}
                    </td>
                </g:if>
                <td style="width: 35%">
                    <g:formatDate date="${precio.fecha}" format="dd-MM-yyyy"/>
                </td>

                %{--                    <g:if test="${session.perfil.codigo == 'CSTO'}">--}%
                %{--                        <td class="precio textRight ${precio.registrado != 'R' ? 'editable' : ''}" data-original="${precio.precioUnitario}" data-valor="${precio.precioUnitario}" id="${precio.id}">--}%
                <td style="width: 35%" class="precio textRight" data-original="${precio.precioUnitario}" data-valor="${precio.precioUnitario}" id="${precio.id}">
                    <g:formatNumber number="${precio.precioUnitario}" maxFractionDigits="5" minFractionDigits="5" format="##,#####0" locale='ec'/>
                </td>

                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-success btn-xs btnEditar" rel="tooltip" title="Editar precio" data-id="${precio.id}">
                        <i class="fa fa-pen"></i>
                    </a>
                </td>
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn ${precio.registrado != 'R' ? 'btn-info' : 'btn-warning'} btn-xs btnRegistrar" rel="tooltip" title="${precio.registrado != 'R' ? 'Registrar precio' : 'Quitar registro de precio'}" data-id="${precio.id}" data-reg="${precio.registrado}">
                        <i class="fa fa-registered"></i>
                    </a>
                </td>
                <td class="delete" style="width: 10%; text-align: center">
                    <g:if test="${precio.registrado != 'R'}">
                        <a href="#" class="btn btn-danger btn-xs btnDelete" rel="tooltip" title="Eliminar precio" data-id="${precio.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </g:if>
                    <g:else>
                        <a href="#" class="btn btn-primary btn-xs btnDeleteReg" rel="tooltip" title="Eliminar precio registrado" data-id="${precio.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </g:else>
                </td>
                %{--                    </g:if>--}%
                %{--                    <g:else>--}%
                %{--                        <td class="precio textRight" data-original="${precio.precioUnitario}" data-valor="${precio.precioUnitario}" id="${precio.id}">--}%
                %{--                            <g:formatNumber number="${precio.precioUnitario}" maxFractionDigits="5" minFractionDigits="5" format="##,#####0" locale='ec'/>--}%
                %{--                        </td>--}%
                %{--                        <td class="delete">--}%

                %{--                        </td>--}%
                %{--                    </g:else>--}%
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<div class="modal hide fade" id="modal_lugar">
    <div class="modal-header" id="modal-header_lugar">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle_lugar"></h3>
    </div>

    <div class="modal-body" id="modalBody_lugar">
    </div>

    <div class="modal-footer" id="modalFooter_lugar">
    </div>
</div>

<div class="modal hide fade" id="modal-tree1">
    <div class="modal-header" id="modal-header-tree1">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle-tree1"></h3>
    </div>

    <div class="modal-body" id="modalBody-tree1">
    </div>

    <div class="modal-footer" id="modalFooter-tree1">
    </div>
</div>

<div class="modal big hide fade" id="modal-tree2">
    <div class="modal-header" id="modal-header-tree2">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle-tree2"></h3>
    </div>

    <div class="modal-body" id="modalBody-tree2" style="width: 970px;">
    </div>

    <div class="modal-footer" id="modalFooter-tree2">
    </div>
</div>


%{--<div id="imprimirDialog">--}%
%{--    <fieldset>--}%
%{--        <div class="span3">--}%
%{--            Elija la fecha de validez del cálculo:--}%
%{--            <div class="span2" style="margin-top: 20px; margin-left: 50px">--}%
%{--            <elm:datepicker name="fechaCalculo" class="span24" id="fechaCalculoId" value="${new java.util.Date()}" style="width: 100px" minDate="new Date(${new Date().format('yyyy')},0,1)" maxDate="new Date(${new Date().format('yyyy')},11,31)"--}%
%{--            readonly="true" />--}%
%{--        </div>--}%
%{--        </div>--}%
%{--    </fieldset>--}%
%{--</div>--}%


<script type="text/javascript">

    revisarBtn();

    function revisarBtn () {
        if(!$(".toggleTipo").hasClass("active")){
            $(".btnNP").removeClass('hidden')
        }else{
           $(".btnNP").addClass('hidden')
        }
    }

    $(".btnRegistrar").click(function () {
        var reg = $(this).data("reg");
        var id = $(this).data("id");
        registrarPrecio(id,reg)
    });

    function registrarPrecio(id, r) {
        var mensaje = '';
        if(r == 'N'){
            mensaje = "<i class='fa fa-3x fa-exclamation-triangle text-warning' ></i> <strong style='font-size: 14px'>  Registrar el precio seleccionado?</strong>"
        }else{
            mensaje = "<i class='fa fa-3x fa-exclamation-triangle text-danger' ></i> <strong style='font-size: 12px'>  El precio seleccionado se encuentra REGISTRADO, desea quitar el registro? </strong>"
        }

        bootbox.confirm({
            message: mensaje,
            buttons: {
                confirm: {
                    label: 'Aceptar',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-primary'
                }
            },
            callback: function (result) {
                if(result){
                    $.ajax({
                        type: 'POST',
                        url: "${createLink(controller: 'mantenimientoItems', action: 'registrar_ajax')}",
                        data:{
                            id: id,
                            reg: r
                        },
                        success: function (msg) {
                            var parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                log(parts[1], 'success');
                                setTimeout(function () {
                                    location.reload()
                                }, 800);
                            }else{
                                log(parts[1], 'error')
                            }
                        }
                    })
                }
            }
        });
    } //createEdit


    $("#btnNew").click(function () {
        crearPrecio();
    });

    function crearPrecio(){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'mantenimientoItems', action:'formPrecio_ajax')}",
            data    : {
                item: '${item?.id}',
                lugar: '${lugarId}'
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCrearPrecios",
                    title : "Crear Precios",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                var $form = $("#frmSaveNuevoPrecio");
                                if ($form.valid()) {
                                    var precio = $("#precioUnitario").val();
                                    if(precio == 0 || precio == 0.0){
                                        bootbox.alert({
                                            message: "<i class='fa fa-exclamation-triangle fa-3x text-warning'></i> Ingrese un valor diferente de cero",
                                            size: 'small'
                                        });
                                        return false
                                    }else{
                                        $.ajax({
                                            type: 'POST',
                                            url: '${createLink(controller: 'mantenimientoItems', action: 'savePrecioNuevo_ajax')}',
                                            data    : $form.serialize(),
                                            success: function (msg){
                                                var parts = msg.split("_")
                                                if(parts[0] == 'ok'){
                                                    log("Precio guardado correctamente","success");
                                                    setTimeout(function () {
                                                        location.reload()
                                                    }, 800);
                                                }else{
                                                    if(parts[0] == 'er'){
                                                        bootbox.alert(parts[1]);
                                                        return false;
                                                    }else{
                                                        log(parts[1],"error")
                                                    }

                                                }
                                            }
                                        });
                                    }
                                }else{
                                    return false;
                                }
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    }

    $(".btnEditar").click(function () {
        var id = $(this).data("id");
        editarPrecio(id)
    });

    function editarPrecio(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'mantenimientoItems', action:'formEditarPrecios_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgEditarPrecios",
                    title : "Editar Precios",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                var nuevoPrecio = $("#precioItem").val();
                                var $form = $("#frmSavePrecios");
                                if ($form.valid()) {
                                    if(nuevoPrecio == ""){
                                        bootbox.alert("<i class='fa fa-exclamation-triangle text-danger fa-3x'></i> <strong style='font-size: 14px'>Debe ingresar un valor!</strong>");
                                        return false;
                                    }else{
                                        $.ajax({
                                            type: 'POST',
                                            url: '${createLink(controller: 'mantenimientoItems', action: 'guardarPrecio_ajax')}',
                                            data:{
                                                id: id,
                                                precio: nuevoPrecio
                                            },
                                            success: function (msg){
                                                if(msg == 'ok'){
                                                    log("Precio guardado correctamente","success");
                                                    setTimeout(function () {
                                                        location.reload()
                                                    }, 800);
                                                }else{
                                                    log("Error al guardar el precio","error")
                                                }
                                            }
                                        });
                                    }
                                }else{
                                    return false;
                                }
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit



    $(".btnDelete").click(function () {
        var id = $(this).data("id");
        borrarPrecios(id, 1)
    });


    $(".btnDeleteReg").click(function () {
        var id = $(this).data("id");
        borrarPrecios(id, 2)
    });



    function borrarPrecios (id, tipo) {

        var texto

        if(tipo == 1){
            texto = "<i class='fa fa-exclamation-triangle text-danger'></i> <strong style='font-size: 12px'> Está seguro de borrar este precio? Esta acción no puede deshacerse </br> * Ingrese su código de autorización </strong>"
        }else{
            texto = "<i class='fa fa-exclamation-triangle text-danger'></i> <strong style='font-size: 12px'> Está seguro de borrar este precio? Esta acción no puede deshacerse " +
                "</br> <i class='fa fa-exclamation-circle text-warning'></i> Este precio se encuentra actualmente REGISTRADO </br>* Ingrese su código de autorización </strong>"
        }

        bootbox.prompt({
            title: texto,
            centerVertical: true,
            size: 'small',
            buttons: {
                confirm: {
                    label: '<i class="fa fa-trash"></i> Borrar',
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-primary'
                }
            },
            callback: function (result) {

                if (result === null) {
                    return;
                } else if (result === '') {
                    bootbox.alert("Ingrese su código de autorización");
                    return false;
                }else{
                    var dialog = cargarLoader("Borrando...");
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'mantenimientoItems', action: 'borrarPrecio_ajax')}',
                        data:{
                            id: id,
                            codigo: result
                        },
                        success: function (msg) {
                            dialog.modal('hide');
                            var parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                log(parts[1],"success");
                                setTimeout(function () {
                                    location.reload(true);
                                }, 1000);
                            }else{
                                if(parts[0] == 'er'){
                                    bootbox.alert(parts[1]);
                                    return false
                                }else{
                                    log(parts[1], "error");
                                    return false
                                }
                            }
                        }
                    });
                }
            }
        });
    }

    function validarNum(ev) {
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
            (ev.keyCode == 188 || ev.keyCode == 190 || ev.keyCode == 110) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39);
    }

    %{--    $('[rel=tooltip]').tooltip();--}%

    %{--    $(".editable").first().addClass("selected");--}%

    %{--    $("#btnNew").click(function () {--}%
    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : "${createLink(action:'formPrecio_ajax')}",--}%
    %{--            data    : {--}%
    %{--                item        : "${item.id}",--}%
    %{--                lugar       : "${lugarId}",--}%
    %{--                nombreLugar : "${lugarNombre}",--}%
    %{--                fecha       : "${fecha}",--}%
    %{--                all         : "${params.all}",--}%
    %{--                ignore      : "${params.ignore}"--}%
    %{--            },--}%
    %{--            success : function (msg) {--}%
    %{--                //////console.log($("#fcDefecto").val())--}%
    %{--                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');--}%
    %{--                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Guardar</a>');--}%

    %{--                btnSave.click(function () {--}%
    %{--                    if ($("#frmSave").valid()) {--}%
    %{--                        btnSave.replaceWith(spinner);--}%
    %{--                    }--}%
    %{--//                    $("#frmSave").submit();--}%

    %{--                    $.ajax({--}%
    %{--                        type    : "POST",--}%
    %{--                        url     : $("#frmSave").attr("action"),--}%
    %{--                        data    : $("#frmSave").serialize(),--}%
    %{--                        success : function (msg) {--}%
    %{--                            if (msg == "OK") {--}%
    %{--                                $("#modal-tree").modal("hide");--}%
    %{--                                var loading = $("<div></div>");--}%
    %{--                                loading.css({--}%
    %{--                                    textAlign : "center",--}%
    %{--                                    width     : "100%"--}%
    %{--                                });--}%
    %{--                                loading.append("Cargando....Por favor espere...<br/>").append(spinnerBg);--}%
    %{--                                $("#info").html(loading);--}%
    %{--                                $.ajax({--}%
    %{--                                    type    : "POST",--}%
    %{--                                    url     : "${createLink(action:'showLg_ajax')}",--}%
    %{--                                    data    : {--}%
    %{--                                        id       : "${params.id}",--}%
    %{--                                        all      : "${params.all}",--}%
    %{--                                        ignore   : "${params.ignore}",--}%
    %{--                                        fecha    : "${params.fecha}",--}%
    %{--                                        operador : "${params.operador}"--}%
    %{--                                    },--}%
    %{--                                    success : function (msg) {--}%
    %{--                                        $("#info").html(msg);--}%
    %{--                                    }--}%
    %{--                                });--}%
    %{--                            } else {--}%
    %{--                                var btnClose = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');--}%
    %{--                                $("#modalTitle").html("Error");--}%
    %{--                                $("#modalBody").html("Ha ocurrido un error al guardar");--}%
    %{--                                $("#modalFooter").html("").append(btnClose);--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    });--}%

    %{--                    return false;--}%
    %{--                });--}%

    %{--                $("#modalTitle").html("Crear Precio");--}%
    %{--                $("#modalBody").html(msg);--}%
    %{--                $("#modalFooter").html("").append(btnOk).append(btnSave);--}%
    %{--                $("#modal-tree").modal("show");--}%
    %{--                $("#fechaPrecio").val($("#fcDefecto").val())--}%
    %{--            }--}%
    %{--        });--}%
    %{--        return false;--}%
    %{--    });--}%

    // $("#btnSave").click(function () {
    %{--$("#dlgLoad").dialog("open");--}%
    %{--var data = "";--}%
    %{--$(".editable").each(function () {--}%
    %{--    var id = $(this).attr("id");--}%
    %{--    var valor = $(this).data("valor");--}%

    %{--    if (parseFloat(valor) > 0 && parseFloat($(this).data("original")) != parseFloat(valor)) {--}%
    %{--        if (data != "") {--}%
    %{--            data += "&";--}%
    %{--        }--}%
    %{--        data += "item=" + id + "_" + valor;--}%
    %{--    }--}%
    %{--});--}%
    %{--$.ajax({--}%
    %{--    type    : "POST",--}%
    %{--    url     : "${createLink(action: 'actualizarPrecios_ajax')}",--}%
    %{--    data    : data,--}%
    %{--    success : function (msg) {--}%
    %{--        $("#dlgLoad").dialog("close");--}%
    %{--        var parts = msg.split("_");--}%
    %{--        var ok = parts[0];--}%
    %{--        var no = parts[1];--}%
    %{--        doHighlight({elem : $(ok), clase : "ok"});--}%
    %{--        doHighlight({elem : $(no), clase : "no"});--}%
    %{--    }--}%
    %{--});--}%
    %{--return false;--}%
    // }); //btnSave

    %{--$(".btnDelete").click(function () {--}%
    %{--    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');--}%
    %{--    var btnSave = $('<a href="#"  class="btn btn-danger"><i class="icon-trash"></i> Eliminar</a>');--}%

    %{--    var id = $(this).attr("id");--}%
    %{--    btnSave.click(function () {--}%
    %{--        btnSave.replaceWith(spinner);--}%
    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : "${createLink(action: 'deletePrecio_ajax')}",--}%
    %{--            data    : {--}%
    %{--                id : id--}%
    %{--            },--}%
    %{--            success : function (msg) {--}%
    %{--                if (msg == "OK") {--}%
    %{--                    $("#modal-tree1").modal("hide");--}%
    %{--                    log("Precio eliminado correctamente", false);--}%
    %{--                    $.ajax({--}%
    %{--                        type    : "POST",--}%
    %{--                        url     : "${createLink(action:'showLg_ajax')}",--}%
    %{--                        data    : {--}%
    %{--                            id       : "${params.id}",--}%
    %{--                            all      : "${params.all}",--}%
    %{--                            ignore   : "${params.ignore}",--}%
    %{--                            fecha    : "${params.fecha}",--}%
    %{--                            operador : "${params.operador}"--}%
    %{--                        },--}%
    %{--                        success : function (msg) {--}%
    %{--                            $("#info").html(msg);--}%
    %{--                        }--}%
    %{--                    });--}%
    %{--                } else {--}%
    %{--                    $("#modal-tree1").modal("hide");--}%
    %{--                    log(msg, true);--}%
    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--        return false;--}%
    %{--    });--}%

    %{--    $("#modalTitle-tree1").html("Confirmación");--}%
    %{--    $("#modalBody-tree1").html("Está seguro de querer eliminar este precio?");--}%
    %{--    $("#modalFooter-tree1").html("").append(btnOk).append(btnSave);--}%
    %{--    $("#modal-tree1").modal("show");--}%
    %{--    return false;--}%
    %{--});--}%

    %{--var valorSueldo--}%
    %{--var id2--}%

    %{--$("#btnCalc2").click(function () {--}%

    %{--    var btnCancel = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');--}%
    %{--    var btnCalc = $('<a href="#"  class="btn btn-success"><i class="icon-check"></i> Calcular</a>');--}%
    %{--    var a = "${anioRef}";--}%

    %{--    var $valor = $("<input type='number' placeholder='Sueldo " + (new Date().getFullYear()) + "'/> ");--}%



    %{--    $valor.bind({--}%
    %{--        keydown : function (ev) {--}%
    %{--            var dec = 5;--}%
    %{--            var val = $(this).val();--}%
    %{--            if (ev.keyCode == 188 || ev.keyCode == 190 || ev.keyCode == 110) {--}%
    %{--                if (!dec) {--}%
    %{--                    return false;--}%
    %{--                } else {--}%
    %{--                    if (val.length == 0) {--}%
    %{--                        $(this).val("0");--}%
    %{--                    }--}%
    %{--                    if (val.indexOf(".") > -1 || val.indexOf(",") > -1) {--}%
    %{--                        return false;--}%
    %{--                    }--}%
    %{--                }--}%
    %{--            } else {--}%
    %{--                if (val.indexOf(".") > -1 || val.indexOf(",") > -1) {--}%
    %{--                    if (dec) {--}%
    %{--                        var parts = val.split(".");--}%
    %{--                        var l = parts[1].length;--}%
    %{--                        if (l >= dec) {--}%
    %{--                            return false;--}%
    %{--                        }--}%
    %{--                    }--}%
    %{--                }--}%
    %{--            }--}%
    %{--            return validarNum(ev);--}%
    %{--        }--}%
    %{--    });--}%

    %{--    btnCalc.click(function () {--}%


    %{--        valorSueldo = $valor.val();--}%

    %{--        $(this).replaceWith(spinner);--}%

    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : "${createLink(action: 'calcPrecioRef_ajax')}",--}%
    %{--            data    : {--}%
    %{--                precio : $valor.val()--}%
    %{--            },--}%
    %{--            success : function (msg) {--}%
    %{--                $("#modal-tree1").modal("hide");--}%
    %{--                $("#btnCalc").hide();--}%
    %{--                $("#spanRef").text("Precio ref: " + msg);--}%
    %{--                $("#btnPrint").show();--}%

    %{--            }--}%
    %{--        });--}%

    %{--        return valorSueldo--}%

    %{--    });--}%

    %{--    var $p1 = $("<p>").html("Por favor ingrese el sueldo básico para el Obrero del año " + (new Date().getFullYear()));--}%
    %{--    var $p2 = $("<p>").html($valor);--}%

    %{--    var $div = $("<div>").append($p1).append($p2);--}%

    %{--    $("#modalTitle-tree1").html("Cálculo del valor por Hora");--}%
    %{--    $("#modalBody-tree1").html($div);--}%
    %{--    $valor.focus();--}%
    %{--    $("#modalFooter-tree1").html("").append(btnCancel).append(btnCalc);--}%
    %{--    $("#modal-tree1").modal("show");--}%

    %{--    return false;--}%
    %{--});--}%


    %{--$("#btnCalc3").click(function () {--}%
    %{--    var btnCancel = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');--}%
    %{--    var btnCalc = $('<a href="#"  class="btn btn-success"><i class="icon-check"></i> Aceptar</a>');--}%
    %{--    var a = "${anioRef}";--}%

    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url     : "${createLink(action: 'calcPrecEq')}",--}%
    %{--        data    : {--}%
    %{--            item : ${item.id}--}%
    %{--        },--}%
    %{--        success : function (msg) {--}%
    %{--            $("#modalTitle-tree2").html("Cálculo del valor por Hora de Equipos");--}%
    %{--            $("#modalBody-tree2").html(msg);--}%
    %{--            $("#modalFooter-tree2").html("").append(btnCancel).append(btnCalc);--}%
    %{--            $("#modal-tree2").modal("show");--}%
    %{--        }--}%
    %{--    });--}%

    %{--    btnCalc.click(function () {--}%
    %{--        $("#modal-tree2").modal("hide");--}%
    %{--        $("#btnCalc").hide();--}%
    %{--        $("#spanRef").text("Precio ref: " + number_format(data.ch, 2, ".", ""));--}%
    %{--    });--}%

    %{--    return false;--}%
    %{--});--}%

    %{--$(".btnDeleteReg").click(function () {--}%
    %{--    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');--}%
    %{--    var btnSave = $('<a href="#"  class="btn btn-danger"><i class="icon-trash"></i> Eliminar</a>');--}%

    %{--    var $auto = $("<input type='password' placeholder='Autorización'/> ");--}%

    %{--    var id = $(this).attr("id");--}%
    %{--    btnSave.click(function () {--}%
    %{--        var auto = $.trim($auto.val());--}%
    %{--        if (auto != "") {--}%
    %{--            btnSave.replaceWith(spinner);--}%
    %{--            $.ajax({--}%
    %{--                type    : "POST",--}%
    %{--                url     : "${createLink(action: 'deletePrecio_ajax')}",--}%
    %{--                data    : {--}%
    %{--                    id   : id,--}%
    %{--                    auto : $auto.val()--}%
    %{--                },--}%
    %{--                success : function (msg) {--}%
    %{--                    if (msg == "OK") {--}%
    %{--                        $("#modal-tree1").modal("hide");--}%
    %{--                        log("Precio eliminado correctamente", false);--}%
    %{--                        $.ajax({--}%
    %{--                            type    : "POST",--}%
    %{--                            url     : "${createLink(action:'showLg_ajax')}",--}%
    %{--                            data    : {--}%
    %{--                                id       : "${params.id}",--}%
    %{--                                all      : "${params.all}",--}%
    %{--                                ignore   : "${params.ignore}",--}%
    %{--                                fecha    : "${params.fecha}",--}%
    %{--                                operador : "${params.operador}"--}%
    %{--                            },--}%
    %{--                            success : function (msg) {--}%
    %{--                                $("#info").html(msg);--}%
    %{--                            }--}%
    %{--                        });--}%
    %{--                    } else {--}%
    %{--                        $("#modal-tree1").modal("hide");--}%
    %{--                        log(msg, true);--}%
    %{--                    }--}%
    %{--                }--}%
    %{--            });--}%
    %{--        }--}%
    %{--        return false;--}%
    %{--    });--}%

    %{--    var $p1 = $("<p>").html("Está seguro de querer eliminar este precio?");--}%
    %{--    var $p2 = $("<p>").html("Este precio está registrado. Para eliminarlo necesita ingresar su clave de autorización.");--}%
    %{--    var $p3 = $("<p>").html($auto);--}%

    %{--    var $div = $("<div>").append($p1).append($p2).append($p3);--}%

    %{--    $("#modalTitle-tree1").html("Confirmación");--}%
    %{--    $("#modalBody-tree1").html($div);--}%
    %{--    $("#modalFooter-tree1").html("").append(btnOk).append(btnSave);--}%
    %{--    $("#modal-tree1").modal("show");--}%
    %{--    return false;--}%
    %{--});--}%

    // $("#btnPrint").click(function () {
    // $("#imprimirDialog").dialog("open");
    // });

    %{--$("#imprimirDialog").dialog({--}%

    %{--        autoOpen  : false,--}%
    %{--        resizable : false,--}%
    %{--        modal     : true,--}%
    %{--        dragable  : false,--}%
    %{--        width     : 320,--}%
    %{--        height    : 220,--}%
    %{--        position  : 'center',--}%
    %{--        title     : 'Elegir fecha de validez de cálculo',--}%
    %{--        buttons   : {--}%
    %{--            "Aceptar" : function () {--}%
    %{--                    console.log( $("#btnPrint").data("id"))--}%
    %{--                location.href="${g.createLink(controller: 'reportes3',action: 'imprimirCalculoValor')}?valor=" + valorSueldo + "&fechaCalculo=" + $("#fechaCalculoId").val() + "&id=" +--}%
    %{--                        $("#btnPrint").data("id")--}%
    %{--                $("#imprimirDialog").dialog("close");--}%

    %{--            },--}%
    %{--            "Cancelar" : function () {--}%

    %{--                $("#imprimirDialog").dialog("close");--}%

    %{--            }--}%



    %{--        }--}%

    %{--})--}%

</script>
%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'tableHandler.js')}"></script>--}%