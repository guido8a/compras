<%@ page import="compras.PrecioRubrosItems" %>

<div id="create-precioRubrosItemsInstance" class="span" role="main">
    <g:form class="form-horizontal" name="frmSaveNuevoPrecio">
        <g:hiddenField name="id" value="${precioRubrosItemsInstance?.id}"/>
        <g:hiddenField id="lugar" name="lugar" value="${lugar ? precioRubrosItemsInstance?.lugar?.id : -1}"/>
        <g:hiddenField id="item" name="item" value="${precioRubrosItemsInstance?.item?.id}"/>
        <g:hiddenField name="all" value="${params.all}"/>
        <g:hiddenField name="ignore" value="${params.ignore}"/>

        <div class="form-group">
            <span>
                <label class="col-md-2 control-label text-info">
                    Item:
                </label>
                <div class="col-md-8">
                    ${precioRubrosItemsInstance?.item?.nombre ?: ''}
                </div>
            </span>
        </div>

        <div class="form-group">
            <span>
                <label class="col-md-2 control-label text-info">
                    Lista:
                </label>
                <div class="col-md-8">
                    ${lugar?.descripcion}
                </div>
            </span>
        </div>

        <div class="form-group">
            <span class="grupo">
                <label for="precioUnitario" class="col-md-2 control-label text-info">
                    Precio Unitario:
                </label>
                <div class="col-md-3">
                    <g:textField name="precioUnitario" maxlength="14" class="form-control required number" value="${precioRubrosItemsInstance?.precioUnitario ?: 0.0}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Fecha:
                </label>
                <div class="col-md-4">
                    <input name="fecha" id='fecha' type='text' class="datetimepicker1 form-control" value="${new Date().format("dd-MM-yyyy")}"/>
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

</script>
