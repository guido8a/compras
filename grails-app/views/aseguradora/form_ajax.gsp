<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="compras.TipoAseguradora" %>
<g:form class="form-horizontal" name="frmSaveAseguradora" action="save">
    <g:hiddenField name="id" value="${aseguradoraInstance?.id}"/>
    <div class="form-group ${hasErrors(bean: aseguradoraInstance, field: 'tipo', 'error')} ">
        <span class="grupo">
            <label for="tipo" class="col-md-2 control-label text-info">
                Tipo de Aseguradora
            </label>
            <div class="col-md-8">
                <g:select name="tipo" from="${compras.TipoAseguradora?.list()?.sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control" value="${aseguradoraInstance?.tipo?.id}" noSelection="['null':'Seleccione...']"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: aseguradoraInstance, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <div class="col-md-8">
                <g:textField name="nombre" maxlength="61" class="form-control required" value="${aseguradoraInstance?.nombre}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: aseguradoraInstance, field: 'direccion', 'error')} ">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <div class="col-md-8">
                <g:textArea name="direccion" maxlength="127" class="form-control" style="resize: none" value="${aseguradoraInstance?.direccion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: aseguradoraInstance, field: 'responsable', 'error')} ">
        <span class="grupo">
            <label for="responsable" class="col-md-2 control-label text-info">
                Responsable
            </label>
            <div class="col-md-8">
                <g:textField name="responsable" maxlength="63" class="form-control" value="${aseguradoraInstance?.responsable}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: aseguradoraInstance, field: 'telefonos', 'error')} ">
        <span class="grupo">
            <label for="telefonos" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <div class="col-md-8">
                <g:textField name="telefonos" maxlength="63" class="form-control digits" value="${aseguradoraInstance?.telefonos}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: aseguradoraInstance, field: 'telefonos', 'error')} ">
        <span class="grupo">
            <label for="mail" class="col-md-2 control-label text-info">
                Mail
            </label>
            <div class="col-md-8">
                <g:textField name="mail" maxlength="63" class="form-control email" value="${aseguradoraInstance?.mail}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmSaveAseguradora").validate({
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
