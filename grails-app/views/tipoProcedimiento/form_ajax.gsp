<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="compras.TipoProcedimiento" %>
<g:form class="form-horizontal" name="frmSaveTipoProcedimiento" action="save">
    <g:hiddenField name="id" value="${tipoProcedimientoInstance?.id}"/>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-8">
                <g:textField name="descripcion" maxlength="64" class="form-control required" value="${tipoProcedimientoInstance?.descripcion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'fuente', 'error')} ">
        <span class="grupo">
            <label for="fuente" class="col-md-2 control-label text-info">
                Fuente
            </label>
            <div class="col-md-4">
                <g:select name="fuente" from="${['OF':'OF', 'OB':'OB']}" optionKey="key" optionValue="value" class="form-control" value="${tipoProcedimientoInstance?.fuente}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'sigla', 'error')} ">
        <span class="grupo">
            <label for="sigla" class="col-md-2 control-label text-info">
                Sigla
            </label>
            <div class="col-md-4">
                <g:textField name="sigla" maxlength="5" class="form-control required" value="${tipoProcedimientoInstance?.sigla}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'bases', 'error')} ">
        <span class="grupo">
            <label for="bases" class="col-md-2 control-label text-info">
                Costo Base
            </label>
            <div class="col-md-4">
                <g:textField name="bases" class="form-control number" value="${tipoProcedimientoInstance?.bases}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'techo', 'error')} ">
        <span class="grupo">
            <label for="techo" class="col-md-2 control-label text-info">
                Techo
            </label>
            <div class="col-md-4">
                <g:textField name="techo" class="form-control number" value="${tipoProcedimientoInstance?.techo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'preparatorio', 'error')} ">
        <span class="grupo">
            <label for="preparatorio" class="col-md-2 control-label text-info">
                Preparatorio
            </label>
            <div class="col-md-4">
                <g:textField name="preparatorio" class="form-control number" value="${tipoProcedimientoInstance?.preparatorio}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'precontractual', 'error')} ">
        <span class="grupo">
            <label for="precontractual" class="col-md-2 control-label text-info">
                Precontractual
            </label>
            <div class="col-md-4">
                <g:textField name="precontractual" class="form-control number" value="${tipoProcedimientoInstance?.precontractual}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: tipoProcedimientoInstance, field: 'contractual', 'error')} ">
        <span class="grupo">
            <label for="contractual" class="col-md-2 control-label text-info">
                Contractual
            </label>
            <div class="col-md-4">
                <g:textField name="contractual" class="form-control number" value="${tipoProcedimientoInstance?.contractual}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmSaveTipoProcedimiento").validate({
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
