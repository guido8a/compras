<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/19
  Time: 9:19
--%>

<%@ page import="compras.Programacion" %>
<g:form class="form-horizontal" name="frmSave-programacionInstance" action="save">
    <g:hiddenField name="id" value="${programacionInstance?.id}"/>

    <div class="form-group ${hasErrors(bean: programacionInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-6">
                <g:textField name="descripcion" maxlength="63" class="form-control required" value="${programacionInstance?.descripcion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: programacionInstance, field: 'fechaInicio', 'error')} ">
        <span class="grupo">
            <label for="fechaInicio" class="col-md-2 control-label text-info">
                Fecha Inicio
            </label>
            <div class="col-md-6">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${programacionInstance?.fechaInicio?.format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: programacionInstance, field: 'fechaFin', 'error')} ">
        <span class="grupo">
            <label for="fechaFin" class="col-md-2 control-label text-info">
                Fecha Fin
            </label>
            <div class="col-md-6">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${programacionInstance?.fechaFin?.format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">


    $(function () {
        $('#datetimepicker1, #datetimepicker2').datetimepicker({
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
    });

    var validator = $("#programacionInstance").validate({
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
