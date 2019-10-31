<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="compras.ValoresAnuales" %>
<g:form class="form-horizontal" name="frmSaveValores" action="save">
    <g:hiddenField name="id" value="${valoresInstance?.id}"/>

    <div class="form-group ${hasErrors(bean: valoresInstance, field: 'anio', 'error')} ">
        <span class="grupo">
            <label for="anio" class="col-md-4 control-label text-info">
                Año
            </label>
            <div class="col-md-3">
                <g:select name="anio" from="${compras.Anio.list().sort{it.anio}}" class="form-control" value="${valoresInstance?.anio?.id}" optionValue="anio" optionKey="id"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: valoresInstance, field: 'seguro', 'error')} ">
        <span class="grupo">
            <label for="sueldoBasicoUnificado" class="col-md-4 control-label text-info">
                Sueldo Básico Unificado
            </label>
            <div class="col-md-3">
                <g:textField name="sueldoBasicoUnificado" maxlength="14" class="form-control required number" value="${valoresInstance?.sueldoBasicoUnificado}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: valoresInstance, field: 'factorCostoRepuestosReparaciones', 'error')} ">
    <span class="grupo">
        <label for="tasaInteresAnual" class="col-md-4 control-label text-info">
            Tasa Interés Anual
        </label>
        <div class="col-md-3">
            <g:textField name="tasaInteresAnual" maxlength="14" class="form-control number" value="${valoresInstance?.tasaInteresAnual}"/>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </span>
    </div>

    <div class="form-group ${hasErrors(bean: valoresInstance, field: 'seguro', 'error')} ">
        <span class="grupo">
            <label for="seguro" class="col-md-2 control-label text-info">
                Seguro
            </label>
            <div class="col-md-3">
                <g:textField name="seguro" maxlength="14" class="form-control number" value="${valoresInstance?.seguro}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="factorCostoRepuestosReparaciones" class="col-md-3 control-label text-info">
                Factor Costo Repuestos
            </label>
            <div class="col-md-3">
                <g:textField name="factorCostoRepuestosReparaciones" maxlength="14" class="form-control number" value="${valoresInstance?.factorCostoRepuestosReparaciones}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: valoresInstance, field: 'costoDiesel', 'error')} ">
        <span class="grupo">
            <label for="inflacion" class="col-md-2 control-label text-info">
                Inflación
            </label>
            <div class="col-md-3">
                <g:textField name="inflacion" maxlength="14" class="form-control number" value="${valoresInstance?.inflacion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="costoDiesel" class="col-md-3 control-label text-info">
                Costo Diesel
            </label>
            <div class="col-md-3">
                <g:textField name="costoDiesel" maxlength="14" class="form-control number" value="${valoresInstance?.costoDiesel}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: valoresInstance, field: 'costoGrasa', 'error')} ">
        <span class="grupo">
            <label for="costoGrasa" class="col-md-2 control-label text-info">
                Costo Grasa
            </label>
            <div class="col-md-3">
                <g:textField name="costoGrasa" maxlength="14" class="form-control number" value="${valoresInstance?.costoGrasa}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>

        <span class="grupo">
            <label for="costoLubricante" class="col-md-3 control-label text-info">
                Costo Lubricante
            </label>
            <div class="col-md-3">
                <g:textField name="costoLubricante" maxlength="14" class="form-control number" value="${valoresInstance?.costoLubricante}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmSaveValores").validate({
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
