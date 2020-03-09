<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Registro de Proyecto</title>

    <style type="text/css">


    .borde {
        border: 1px solid #000000;
        -moz-border-radius: 9px;
        -webkit-border-radius:9px;
        padding: 10px;
    }

    .bordeAzul {
        border: 1px solid #294ea3;
        -moz-border-radius: 9px;
        -webkit-border-radius:9px;
        padding: 10px;
    }
    </style>

    <asset:javascript src="/apli/jquery.bootstrap.wizard.js"/>
</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 25px">
    <div class="btn-group">
        <a href="#" class="btn btn-primary btnListar">
            <i class="fa fa-list"></i> Lista
        </a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-info btnCrear">
            <i class="fa fa-file"></i> Nuevo
        </a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-success btnGuardar">
            <i class="fa fa-save"></i> Guardar
        </a>
    </div>
    <g:if test="${proyectoInstance?.id}">
        <div class="btn-group">
            <a href="#" class="btn btn-warning btnRegistrar">
                <g:if test="${proyectoInstance?.estado != 'R'}">
                    <i class="fa fa-check"></i> Registrar
                </g:if>
                <g:else>
                    <i class="fa fa-times-circle"></i> Quitar Registro
                </g:else>
            </a>
        </div>
        <div class="btn-group">
            <a href="#" class="btn btn-info btnImprimir">
                <i class="fa fa-print"></i> Imprimir
            </a>
        </div>
        <div class="btn-group" style="float: right">
            <a href="#" class="btn btn-success btnDetalle">
                <i class="fa fa-list-alt"></i> Detalle
            </a>
        </div>
    </g:if>
</div>

<div class="tab-content col-md-12 borde">
    <g:form class="form-horizontal" name="frmSaveProyecto" action="save">
        <g:hiddenField name="id" value="${proyectoInstance?.id}"/>

        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'unidad', 'error')} ${hasErrors(bean: proyectoInstance, field: 'codigo', 'error')}">
            <span class="grupo">
                <label for="unidadRequirente" class="col-md-2 control-label text-info">
                    Unidad Requirente
                </label>
                <div class="col-md-5">
                    <g:select name="unidadRequirente" class="form-control" from="${seguridad.Departamento.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" value="${proyectoInstance?.unidadRequirenteId}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="codigo" class="col-md-1 control-label text-info">
                    Código
                </label>
                <div class="col-md-2">
                    <g:textField name="codigo" class='form-control text-uppercase required' maxlength="15" value="${proyectoInstance?.codigo}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-2">
                    <g:textField name="estado" class='form-control' style="background-color: ${proyectoInstance?.estado == 'R' ? '#47b636' : '#e1a628'}; text-align: center; font-weight: bold" disabled="" title="${proyectoInstance?.estado == 'R' ? 'Registrado' : 'No registrado'}" value="${proyectoInstance?.estado == 'R' ? 'Registrado' : 'No Registrado'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'nombre', 'error')}">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-10">
                    <g:textArea name="nombre" class='form-control required' maxlength="127" value="${proyectoInstance?.nombre}" style="resize: none"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'tipoProyecto', 'error')} ${hasErrors(bean: proyectoInstance, field: 'tipoAdquisicion', 'error')}">
            <span class="grupo">
                <label for="tipoAdquisicion" class="col-md-2 control-label text-info">
                    Tipo
                </label>
                <div class="col-md-3">
                    <g:select name="tipoAdquisicion" from="${compras.TipoAdquisicion.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control" value="${proyectoInstance?.tipoAdquisicion?.id}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="tipoProyecto" class="col-md-2 control-label text-info">
                    Tipo de Proyecto
                </label>
                <div class="col-md-3">
                    <g:select name="tipoProyecto" from="${compras.TipoProyecto.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control" value="${proyectoInstance?.tipoProyecto?.id}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'marcoLegal', 'error')} ${hasErrors(bean: proyectoInstance, field: 'categoriaCPC', 'error')}">
            <span class="grupo">
                <label for="categoriaCPC" class="col-md-2 control-label text-info">
                    Categoría del producto CPC
                </label>
                <div class="col-md-5">
                    <g:hiddenField name="codigoComprasPublicas" value="${proyectoInstance?.codigoComprasPublicas?.id}"/>
                    <g:textField name="categoriaCPC" class="form-control" readonly="" value="${proyectoInstance?.codigoComprasPublicas ? ( (proyectoInstance?.codigoComprasPublicas?.numero ?: '') + " - " + (proyectoInstance?.codigoComprasPublicas?.descripcion ?: '')) : ''}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <div class="col-md-1">
                <a href="#" class="btn btn-primary btnBuscarCPC" title="Buscar CPC">
                    <i class="fa fa-search-plus"></i>
                </a>
            </div>
            <span class="grupo">
                <label for="marcoLegal" class="col-md-1 control-label text-info">
                    Marco Legal
                </label>
                <div class="col-md-3">
                    <g:select name="marcoLegal" from="${['0' : 'LEYES']}" optionValue="value" optionKey="key" class="form-control"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'comunidad', 'error')} ${hasErrors(bean: proyectoInstance, field: 'canton', 'error')} ${hasErrors(bean: proyectoInstance, field: 'parroquia', 'error')}" >
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                </label>
                <div class="col-md-3">
                    <label for="canton" class="col-md-2 control-label text-info">
                        Cantón
                    </label>
                    <g:textField name="canton" class='form-control' disabled="" value="${proyectoInstance?.comunidad?.parroquia?.canton?.nombre}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-3">
                    <label for="parroquia" class="col-md-2 control-label text-info">
                        Parroquia
                    </label>
                    <g:textField name="parroquia" class='form-control' disabled="" value="${proyectoInstance?.comunidad?.parroquia?.nombre}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-3">
                    <label for="comunidad" class="col-md-2 control-label text-info">
                        Comunidad
                    </label>
                    <g:hiddenField name="comunidad" value="${proyectoInstance?.comunidad?.id}"/>
                    <g:textField name="comunidad_name" class='form-control required' disabled=""  value="${proyectoInstance?.comunidad?.nombre}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-1" style="margin-top: 12px;">
                    <label for="comunidad" class="col-md-2 control-label text-info">
                    </label>
                    <a href="#" class="btn btn-primary btnBuscar" title="Buscar Comunidad">
                        <i class="fa fa-search-plus"></i>
                    </a>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'sitio', 'error')} ${hasErrors(bean: proyectoInstance, field: 'sitio', 'error')}" style="margin-top: 15px">
            <span class="grupo">
                <label for="sitio" class="col-md-2 control-label text-info">
                    Sitio
                </label>
                <div class="col-md-3">
                    <g:textArea name="sitio" class='form-control' maxlength="63" style="resize: none" value="${proyectoInstance?.sitio}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="sitioEntrega" class="col-md-1 control-label text-info">
                    Sitio de entrega
                </label>
                <div class="col-md-3">
                    <g:textArea name="sitioEntrega" class='form-control' maxlength="63" style="resize: none" value="${proyectoInstance?.sitioEntrega}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="distancia" class="col-md-1 control-label text-info">
                    Distancia
                </label>
                <div class="col-md-2">
                    <g:textField name="distancia" class='form-control number' maxlength="5" style="resize: none" value="${proyectoInstance?.distancia}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'origen', 'error')}">
            <span class="grupo">
                <label for="origen" class="col-md-2 control-label text-info">
                    Origen del producto
                </label>
                <div class="col-md-10">
                    <g:textArea name="origen" class='form-control' maxlength="511" style="resize: none" value="${proyectoInstance?.origen}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'caracteristicasTecnicas', 'error')}">
            <span class="grupo">
                <label for="caracteristicasTecnicas" class="col-md-2 control-label text-info">
                    Caracteristicas Técnicas
                </label>
                <div class="col-md-10">
                    <g:textArea name="caracteristicasTecnicas" class='form-control' maxlength="511" style="resize: none" value="${proyectoInstance?.caracteristicasTecnicas}" />
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="col-md-12 form-group ${hasErrors(bean: proyectoInstance, field: 'responsable', 'error')} ${hasErrors(bean: proyectoInstance, field: 'revisor', 'error')} ${hasErrors(bean: proyectoInstance, field: 'inspector', 'error')}">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">

                </label>
                <div class="col-md-3">
                    <label for="responsable" class="col-md-2 control-label text-info">
                        Responsable
                    </label>
                    <g:select name="responsable" from="${reponsables}" class="form-control" optionValue="${{it.apellido + " " + it.nombre}}" optionKey="id" style="font-size: 10px" value="${proyectoInstance?.responsable?.id}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-3">
                    <label for="revisor" class="control-label text-info">
                        Revisor
                    </label>
                    <g:select name="revisor" from="${revisores}" class="form-control" optionValue="${{it.apellido + " " + it.nombre}}" optionKey="id" style="font-size: 10px" value="${proyectoInstance?.revisor?.id}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-3">
                    <label for="inspector" class="control-label text-info">
                        Inspector
                    </label>
                    <g:select name="inspector" from="${inspectores}" class="form-control" optionValue="${{it.apellido + " " + it.nombre}}" optionKey="id" style="font-size: 10px" value="${proyectoInstance?.inspector?.id}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
    </g:form>
</div>

%{--<div class="btn-toolbar toolbar" style="margin-bottom: 25px">--}%
%{--    <g:if test="${proyectoInstance?.id}">--}%
%{--        <div class="btn-group">--}%
%{--            <a href="#" class="btn btn-success btnDetalle">--}%
%{--                <i class="fa fa-print"></i> Detalle--}%
%{--            </a>--}%
%{--        </div>--}%
%{--    </g:if>--}%
%{--</div>--}%

<script type="text/javascript">

    $(".btnDetalle").click(function () {
        var id = '${proyectoInstance?.id}';
        location.href="${createLink(controller: 'proyecto', action: 'detalle')}?id=" + id
    });

    $(".btnImprimir").click(function () {
        var id = '${proyectoInstance?.id}';
        location.href = "${createLink(controller: 'reportes', action: 'reporteProyecto')}?id=" + id;
    });

    $(".btnRegistrar").click(function () {

        bootbox.confirm({
            title: "Cambiar estado del proyecto",
            message: "<strong style='font-size: 14px'>Está seguro de cambiar el estado del proyecto?.</strong>",
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
                    var dialog = cargarLoader("Borrando...");
                    $.ajax({
                        type: 'POST',
                        url:'${createLink(controller: 'proyecto', action: 'cambiarEstado_ajax')}',
                        data:{
                            id: '${proyectoInstance?.id}'
                        },
                        success:function (msg){
                            dialog.modal('hide');
                            var parts = msg.split("_")
                            if(parts[0] == 'ok'){
                                location.href="${createLink(controller: 'proyecto', action: 'registroProyecto')}?id=" + '${proyectoInstance?.id}'
                            }else{
                                if(parts[0] == 'er'){
                                    mensajeError("No se puede cambiar el estado del proyecto, uno o mas precios ya se encuentran en uso en los proyectos: " + "<br>" +  parts[1])
                                }else{
                                    log("Error al cambiar el estado del proyecto","error");
                                }
                            }
                        }
                    });
                }
            }
        });
    });

    $(".btnCrear").click(function () {
        var dialog = cargarLoader("Cargando...");
        location.href="${createLink(controller: 'proyecto', action: 'registroProyecto')}";
    });

    $(".btnListar").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'proyecto', action:'list')}",
            data    : { },
            success : function (msg) {
                bootbox.dialog({
                    id    : 'dlgBuscarProyecto',
                    title : "Buscar Proyecto",
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

    $(".btnGuardar").click(function () {
        submitFormProyecto();
    });

    function submitFormProyecto() {
        var $form = $("#frmSaveProyecto");
        if ($form.valid()) {

            var comunidad = $("#comunidad_name").val();

            if(comunidad == ''){
                bootbox.alert('<i class="fa fa-exclamation-circle text-warning fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Seleccione una comunidad" + '</strong>');
                return false;
            }else{
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
                            log(parts[1], "success");
                            setTimeout(function () {
                                location.href="${createLink(controller: 'proyecto', action: 'registroProyecto')}?id=" + parts[2]
                            }, 1000);
                        }else{
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }
                    }
                });
            }
        } else {
            return false;
        }
    }

    $(".btnBuscar").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'proyecto', action:'buscarComunidad')}",
            data    : { },
            success : function (msg) {
                bootbox.dialog({
                    id    : 'dlgBuscarComunidad',
                    title : "Buscar comunidad",
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

    $(".btnBuscarCPC").click(function () {
        cargarBuscarCodigo(2)
    });

    function cargarBuscarCodigo(tipo) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'codigoComprasPublicas', action:'buscarCodigo')}",
            data    : {
                tipo: tipo
            },
            success : function (msg) {
                bootbox.dialog({
                    id    : 'dlgTablaCPC',
                    title : "Buscar código de compras públicas",
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

    var validator = $("#frmSaveProyecto").validate({
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
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });

    function mensajeError(mensaje){
        return  bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 13px">' + mensaje + '</strong>');
    }

</script>

</body>