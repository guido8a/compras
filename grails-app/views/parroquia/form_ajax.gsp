
<%@ page import="compras.Canton; compras.Parroquia" %>
<div id="create-parroquiaInstance" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-parroquiaInstance" action="save">
        <g:hiddenField name="id" value="${parroquiaInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: parroquiaInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>
                <div class="col-md-3">
                    <g:textField name="codigo" maxlength="6" class="form-control required number" value="${parroquiaInstance?.codigo}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: parroquiaInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="63" class="form-control required" value="${parroquiaInstance?.nombre}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: parroquiaInstance, field: 'canton', 'error')} ">
            <span class="grupo">
                <label for="canton" class="col-md-2 control-label text-info">
                    Cantón
                </label>
                <div class="col-md-6">
                    <g:select id="canton" name="canton" from="${compras.Canton.list()}" optionKey="id" optionValue="nombre" disabled="" class="many-to-one form-control" value="${parroquiaInstance?.canton?.id ?: compras.Canton.get(padre)?.id}" noSelection="['null': '']"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: parroquiaInstance, field: 'urbana', 'error')} ">
            <span class="grupo">
                <label for="urbana" class="col-md-2 control-label text-info">
                    Urbana
                </label>
                <div class="col-md-2">
                    <g:select id="urbana" name="urbana" from="${['0':'SI', '1': 'NO']}" optionValue="value" optionKey="key" class="form-control" value="${parroquiaInstance?.urbana}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: parroquiaInstance, field: 'latitud', 'error')} ">
            <span class="grupo">
                <label for="latitud" class="col-md-2 control-label text-info">
                    Latitud
                </label>
                <div class="col-md-3">
                    <g:textField name="latitud" class="form-control number" value="${parroquiaInstance?.latitud}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: parroquiaInstance, field: 'longitud', 'error')} ">
            <span class="grupo">
                <label for="longitud" class="col-md-2 control-label text-info">
                    Longitud
                </label>
                <div class="col-md-3">
                    <g:textField name="longitud" class="form-control number" value="${parroquiaInstance?.longitud}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
                
    </g:form>

<script type="text/javascript">
    var validator = $("#frmSave-parroquiaInstance").validate({
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
</script>
