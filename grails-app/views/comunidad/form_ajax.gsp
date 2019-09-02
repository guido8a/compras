<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 8:45
--%>


<%@ page import="compras.Comunidad; compras.Parroquia" %>
<div id="create-comunidadInstance" class="span" role="main">
<g:form class="form-horizontal" name="frmSave-comunidadInstance" action="save">
    <g:hiddenField name="id" value="${comunidadInstance?.id}"/>

    <div class="form-group ${hasErrors(bean: comunidadInstance, field: 'numero', 'error')} ">
        <span class="grupo">
            <label for="numero" class="col-md-2 control-label text-info">
                Código
            </label>
            <div class="col-md-3">
                <g:textField name="numero" maxlength="8" class="form-control required number" value="${comunidadInstance?.numero}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: comunidadInstance, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <div class="col-md-6">
                <g:textField name="nombre" maxlength="63" class="form-control required" value="${comunidadInstance?.nombre}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: comunidadInstance, field: 'parroquia', 'error')} ">
        <span class="grupo">
            <label for="parroquia" class="col-md-2 control-label text-info">
                Parroquia
            </label>
            <div class="col-md-6">
                <g:select id="parroquia" name="parroquia" from="${compras.Parroquia.list()}" optionKey="id" optionValue="nombre" disabled="" class="many-to-one form-control" value="${comunidadInstance?.parroquia?.id ?: compras.Parroquia.get(padre)?.id}" noSelection="['null': '']"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: comunidadInstance, field: 'latitud', 'error')} ">
        <span class="grupo">
            <label for="latitud" class="col-md-2 control-label text-info">
                Latitud
            </label>
            <div class="col-md-3">
                <g:textField name="latitud" class="form-control number" value="${comunidadInstance?.latitud}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: comunidadInstance, field: 'longitud', 'error')} ">
        <span class="grupo">
            <label for="longitud" class="col-md-2 control-label text-info">
                Longitud
            </label>
            <div class="col-md-3">
                <g:textField name="longitud" class="form-control number" value="${comunidadInstance?.longitud}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

</g:form>

<script type="text/javascript">
    var validator = $("#frmSave-comunidadInstance").validate({
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
