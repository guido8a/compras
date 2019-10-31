
%{--<%@ page import="compras.Provincia" %>--}%

%{--<div id="create-provinciaInstance" class="span" role="main">--}%
<g:form class="form-horizontal" name="frmSave-provinciaInstance" action="save">
    <g:hiddenField name="id" value="${provinciaInstance?.id}"/>

    <div class="form-group ${hasErrors(bean: provinciaInstance, field: 'numero', 'error')} ">
        <span class="grupo">
            <label for="numero" class="col-md-2 control-label text-info">
                Número
            </label>
            <div class="col-md-4">
                <g:textField name="numero" maxlength="2" class="numeroV form-control required number" value="${provinciaInstance?.numero}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: provinciaInstance, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <div class="col-md-8">
                <g:textField name="nombre" maxlength="63" class="form-control required text-uppercase" value="${provinciaInstance?.nombre}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: provinciaInstance, field: 'latitud', 'error')} ">
        <span class="grupo">
            <label for="latitud" class="col-md-2 control-label text-info">
                Latitud
            </label>
            <div class="col-md-4">
                <g:textField name="latitud" class="form-control number" value="${provinciaInstance?.latitud}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: provinciaInstance, field: 'longitud', 'error')} ">
        <span class="grupo">
            <label for="longitud" class="col-md-2 control-label text-info">
                Longitud
            </label>
            <div class="col-md-4">
                <g:textField name="longitud" class="form-control number" value="${provinciaInstance?.longitud}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

</g:form>


<script type="text/javascript">
    var validator = $("#frmSave-provinciaInstance").validate({
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
