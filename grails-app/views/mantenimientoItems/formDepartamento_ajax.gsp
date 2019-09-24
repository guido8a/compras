<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 06/09/19
  Time: 12:15
--%>

<%@ page import="compras.Transporte; compras.DepartamentoItem" %>

<div id="create" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-subGrupoInstance" action="saveDepartamento_ajax">
        <g:hiddenField name="id" value="${departamentoItemInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: departamentoItemInstance, field: 'subgrupo', 'error')} ">
            <span class="subgrupo">
                <label class="col-md-2 control-label text-info">
                   Grupo
                </label>
                <div class="col-md-6">
                    <g:select id="subgrupo" name="subgrupo" from="${compras.SubgrupoItems.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" disabled="" class="many-to-one form-control" value="${departamentoItemInstance?.subgrupo?.id ?: compras.SubgrupoItems.get(padre)?.id}" noSelection="['null': '']"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: departamentoItemInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>
                <div class="col-md-3">
                    <g:textField name="codigo" maxlength="3" class="form-control required number" value="${departamentoItemInstance?.codigo}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: departamentoItemInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-8">
                    <g:textArea name="descripcion" maxlength="50" style="resize: none" class="form-control required text-uppercase" value="${departamentoItemInstance?.descripcion}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <g:if test="${compras.SubgrupoItems.get(padre)?.grupo?.codigo?.toInteger() != 1}">
            <div class="form-group ${hasErrors(bean: departamentoItemInstance, field: 'transporte', 'error')} ">
                <span class="grupo">
                    <label for="transporte" class="col-md-4 control-label text-info">
                        Grupo asociado a transporte
                    </label>
                    <div class="col-md-6">
                        <g:select id="transporte" name="transporte.id" from="${compras.Transporte.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion"
                                  class="many-to-one " value="${departamentoItemInstance?.transporte?.id}" noSelection="['null': '']"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
        </g:if>
    </g:form>
</div>

<script type="text/javascript">
    var validator = $("#frmSave-subGrupoInstance").validate({
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
