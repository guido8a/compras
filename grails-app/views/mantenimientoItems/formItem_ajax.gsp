<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 09/09/19
  Time: 11:54
--%>

<%@ page import="compras.DepartamentoItem; compras.CodigoComprasPublicas; compras.Item" %>

<div id="create" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-itemInstance" action="saveItem_ajax">
        <g:hiddenField name="id" value="${itemInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'departamento', 'error')} ">
            <span class="departamento">
                <label class="col-md-2 control-label text-info">
                    Subgrupo
                </label>
                <div class="col-md-8">
                    <g:select id="departamento" name="departamento" from="${compras.DepartamentoItem.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" disabled="" class="many-to-one form-control" value="${itemInstance?.departamento?.id ?: compras.DepartamentoItem.get(padre)?.id}" noSelection="['null': '']"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>
                <div class="col-md-2">
                    <g:textField name="codigo1" maxlength="3" readonly="" class="form-control" value="${compras.DepartamentoItem.get(padre).subgrupo.codigo}"/>
                </div>
                <div class="col-md-2">
                    <g:textField name="codigo2" maxlength="3" readonly="" class="form-control" value="${compras.DepartamentoItem.get(padre).codigo}"/>
                </div>
                <div class="col-md-3">
                    <g:textField name="codigo" maxlength="3" class="form-control required number" value="${itemInstance?.codigo}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-8">
                    <g:textArea name="nombre" maxlength="160" style="resize: none" class="form-control required text-uppercase" value="${itemInstance?.nombre}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'codigoComprasPublicas', 'error')} ">
            <span class="grupo">
                <label for="codigoComprasPublicas" class="col-md-2 control-label text-info">
                    Código CPC (SERCOP)
                </label>
                <div class="row">
                    <div class="col-md-8">
                        <g:hiddenField name="codigoComprasPublicas" value="${itemInstance?.codigoComprasPublicas?.id}"/>
                        <g:textField name="codigoComprasPublicasNombre" class="form-control required text-uppercase" value="${itemInstance?.codigoComprasPublicas ? (itemInstance?.codigoComprasPublicas?.numero + " - " + itemInstance?.codigoComprasPublicas?.descripcion) : ''}"/>
                    </div>
                    <div class="col-md-2">
                        <a href="#" class="btn btn-info" id="btnBuscarCPC" >
                            Buscar CPC
                        </a>
                    </div>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'unidad', 'error')} ">
            <span class="unidad">
                <label class="col-md-2 control-label text-info">
                    Unidad
                </label>
                <div class="col-md-8">
                    <g:select id="unidad" name="unidad" from="${compras.Unidad.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="many-to-one form-control" value="${itemInstance?.unidad?.id}" noSelection="['null': '']"/>
                </div>
            </span>
        </div>


        <div class="form-group ${hasErrors(bean: itemInstance, field: 'tipoLista', 'error')} ">
            <span class="tipoLista">
                <label class="col-md-2 control-label text-info">
                    Lista de Precios
                </label>
                <div class="col-md-8">
                    <g:if test="${tipo == 'Mano de obra'}">
                        <g:select id="tipoLista" name="tipoLista" from="${lista2}" optionKey="id" optionValue="descripcion" class="many-to-one form-control" value="${itemInstance?.tipoLista?.id}"/>
                    </g:if>
                    <g:else>
                        <g:select id="tipoLista" name="tipoLista" from="${tipoLista}" optionKey="id" optionValue="descripcion" class="many-to-one form-control" value="${itemInstance?.tipoLista?.id}"/>
                    </g:else>
                </div>
            </span>
        </div>

        <g:if test="${tipo == 'Material'}">
            <div class="form-group ${hasErrors(bean: itemInstance, field: 'peso', 'error')} ">
                <span class="grupo">
                    <label for="peso" class="col-md-2 control-label text-info">
                        Peso/Volumen
                    </label>
                    <div class="col-md-3">
                        <g:textField name="peso" maxlength="20" style="resize: none" class="form-control number" value="${itemInstance?.peso}"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
        </g:if>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'estado', 'error')} ">
            <span class="estado">
                <label class="col-md-2 control-label text-info">
                    Estado
                </label>
                <div class="col-md-4">
                    <g:select id="estado" name="estado" from="${['A': 'Activo', 'D': 'Dado de baja']}" optionKey="key" optionValue="value" class="many-to-one form-control" value="${itemInstance?.estado}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'fecha', 'error')} ">
            <span class="fecha">
                <label class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-4">
                    <input name="fecha" id='fecha' type='text' class="datetimepicker1 form-control" value="${itemInstance?.fecha?.format("dd-MM-yyyy")}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: itemInstance, field: 'observaciones', 'error')} ">
            <span class="observaciones">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-8">
                    <g:textArea name="observaciones" maxlength="127" style="resize: none" class="form-control" value="${itemInstance?.observaciones}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    $('.datetimepicker1').datetimepicker({
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

    $("#btnBuscarCPC").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'codigoComprasPublicas', action:'buscarCodigo')}",
            data    : { },
            success : function (msg) {
                bootbox.dialog({
                    id    : 'dlgTablaCPC',
                    title : "Buscar código de compras públicas",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

</script>
