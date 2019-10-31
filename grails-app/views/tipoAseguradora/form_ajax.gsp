<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="compras.TipoAseguradora" %>
<g:form class="form-horizontal" name="frmSaveTipoAseguradora" action="save">
    <g:hiddenField name="id" value="${tipoAseguradoraInstance?.id}"/>
    <div class="form-group ${hasErrors(bean: tipoAseguradoraInstance, field: 'codigo', 'error')} ">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <div class="col-md-3">
                <g:textField name="codigo" maxlength="1" class="form-control required text-uppercase" value="${tipoAseguradoraInstance?.codigo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoAseguradoraInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-8">
                <g:textField name="descripcion" maxlength="31" class="form-control required" value="${tipoAseguradoraInstance?.descripcion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmSaveTipoAseguradora").validate({
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
