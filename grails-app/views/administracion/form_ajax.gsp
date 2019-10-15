<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="seguridad.Direccion" %>
<g:form class="form-horizontal" name="frmSaveAdministracion" action="save">
    <g:hiddenField name="id" value="${administracionInstance?.id}"/>

    <div class="form-group ${hasErrors(bean: administracionInstance, field: 'nombrePrefecto', 'error')} ">
        <span class="grupo">
            <label for="nombrePrefecto" class="col-md-2 control-label text-info">
                Prefecto
            </label>
            <div class="col-md-10">
                <g:textField name="nombrePrefecto" maxlength="63" class="form-control required" value="${administracionInstance?.nombrePrefecto}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: administracionInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-10">
                <g:textField name="descripcion" maxlength="63" class="form-control required" value="${administracionInstance?.descripcion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: administracionInstance, field: 'fechaInicio', 'error')} ">
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Fecha Inicio
            </label>
            <div class="col-md-4">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control required" value="${administracionInstance?.fechaInicio?.format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: administracionInstance, field: 'fechaFin', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Fecha Fin
            </label>
            <div class="col-md-4">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control required" value="${administracionInstance?.fechaFin?.format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">


    $('#datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        // inline: true,
        sideBySide: true,
        showClose: true,
        icons: {
            // close: 'closeText'
        }
    });

    $('#datetimepicker2').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        // inline: true,
        sideBySide: true,
        showClose: true,
        icons: {
            // close: 'closeText'
        }
    });

    var validator = $("#frmSaveAdministracion").validate({
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
