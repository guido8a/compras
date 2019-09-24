<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/09/19
  Time: 10:37
--%>

<%@ page import="compras.SubgrupoItems" %>

<div id="create" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-grupoInstance" action="saveSubGrupo_ajax">
        <g:hiddenField name="id" value="${subgrupoItemsInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'grupo', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Padre
                </label>
                <div class="col-md-4">
                    <g:select id="grupo" name="grupo" from="${compras.Grupo.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" disabled="" class="many-to-one form-control" value="${subgrupoItemsInstance?.grupo?.id ?: compras.Grupo.get(padre)?.id}" noSelection="['null': '']"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>
                <div class="col-md-3">
                    <g:textField name="codigo" maxlength="3" class="form-control required number" value="${subgrupoItemsInstance?.codigo}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" class="form-control required text-uppercase" value="${subgrupoItemsInstance?.descripcion}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
    </g:form>
</div>

<script type="text/javascript">
    var validator = $("#frmSave-grupoInstance").validate({
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