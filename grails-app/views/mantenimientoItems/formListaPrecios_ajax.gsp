<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/09/19
  Time: 9:48
--%>

<%@ page import="compras.Lugar" %>

<div id="create" class="span" role="main">
    <g:form class="form-horizontal" name="frmSaveListaPrecios" action="guardarListaPrecios_ajax">
        <g:hiddenField name="id" value="${lugarInstance?.id}"/>
        <g:hiddenField name="codigo" value="${lugarInstance?.codigo ?: ultimo +1}"/>

        <div class="form-group ${hasErrors(bean: lugarInstance, field: 'tipoLista', 'error')}">
            <span class="tipoLista">
                <label class="col-md-2 control-label text-info">
                    Lista de Precios
                </label>
                <div class="col-md-8">
                    <g:select id="tipoLista" name="tipoLista" from="${lista}" optionKey="id" optionValue="descripcion" class="many-to-one form-control" value="${lugarInstance?.tipoLista?.id}"/>
                </div>
            </span>
        </div>


        <div class="form-group ${hasErrors(bean: lugarInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-8">
                    <g:textArea name="descripcion" maxlength="40" style="resize: none" class="form-control required text-uppercase" value="${lugarInstance?.descripcion}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

    </g:form>
</div>