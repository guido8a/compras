<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="compras.Anio" %>
<g:form class="form-horizontal" name="frmSaveAnio" action="save">
    <g:hiddenField name="id" value="${anioInstance?.id}"/>


    <div class="form-group ${hasErrors(bean: anioInstance, field: 'anio', 'error')} ">
        <span class="grupo">
            <label for="anio" class="col-md-2 control-label text-info">
                Año
            </label>
            <div class="col-md-4">
                <g:textField name="anio" id="anioId" maxlength="4" class="form-control required digits" value="${anioInstance?.anio}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmSaveAnio").validate({
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
