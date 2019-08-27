
<style>

.closeText:before {

    content: 'Cerrar';
}

</style>

<g:if test="${!zonaInstance}">
    <elm:notFound elem="Actividad" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmZona" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${zonaInstance?.id}" />

        <div class="form-group ${hasErrors(bean: zonaInstance, field: 'numero', 'error')} ">
            <span class="grupo">
                <label for="numero" class="col-md-2 control-label text-info">
                    Número
                </label>
                <div class="col-md-4">
                   <g:textField name="numero" value="${zonaInstance?.numero}" class="form-control number required"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: zonaInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-10">
                    <g:textField name="nombre" value="${zonaInstance?.nombre}" class="form-control required"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: zonaInstance, field: 'latitud', 'error')} ">
            <span class="grupo">
                <label for="latitud" class="col-md-2 control-label text-info">
                    Latitud
                </label>
                <div class="col-md-4">
                    <g:textField name="latitud" value="${zonaInstance?.latitud}" class="form-control number"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: zonaInstance, field: 'longitud', 'error')} ">
            <span class="grupo">
                <label for="longitud" class="col-md-2 control-label text-info">
                    Longitud
                </label>
                <div class="col-md-4">
                    <g:textField name="longitud" value="${zonaInstance?.longitud}" class="form-control number"/>
                </div>
            </span>
        </div>

    </g:form>

    <script type="text/javascript">



        var validator = $("#frmZona").validate({
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

</g:else>