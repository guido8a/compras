<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="compras.TipoLista" %>
<g:form class="form-horizontal" name="frmSaveTipoLista" action="save">
    <g:hiddenField name="id" value="${tipoListaInstance?.id}"/>

    <div class="form-group ${hasErrors(bean: tipoListaInstance, field: 'codigo', 'error')} ">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <div class="col-md-3">
                <g:textField name="codigo" maxlength="2" class="form-control text-uppercase required" value="${tipoListaInstance?.codigo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tipoListaInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-10">
                <g:textField name="descripcion" maxlength="63" class="form-control required" value="${tipoListaInstance?.descripcion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tipoListaInstance, field: 'unidad', 'error')} ">
        <span class="grupo">
            <label for="unidad" class="col-md-2 control-label text-info">
                Unidad
            </label>
            <div class="col-md-3">
                <g:textField name="unidad" maxlength="5" class="form-control" value="${tipoListaInstance?.unidad}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

</g:form>

<script type="text/javascript">
    var validator = $("#frmSaveTipoLista").validate({
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
