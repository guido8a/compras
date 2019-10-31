<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 29/10/19
  Time: 10:59
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<%@ page import="compras.Proveedor" %>

<g:form class="form-horizontal" name="frmSaveProveedor" action="save">
    <g:hiddenField name="id" value="${proveedorInstance?.id}"/>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'canton', 'error')} ">
        <span class="grupo">
            <label for="provincia" class="col-md-2 control-label text-info">
                Provincia
            </label>
            <div class="col-md-4">
                <g:select name="provincia" id="provinciaId" from="${compras.Provincia.list().sort{it.nombre}}" optionValue="nombre" optionKey="id" class="form-control"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
            <label for="canton" class="col-md-2 control-label text-info">
                Cantón
            </label>
            <div class="col-md-4" id="divCanton">
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'ruc', 'error')} ${hasErrors(bean: proveedorInstance, field: 'tipo', 'error')}">
        <span class="grupo">
            <label for="ruc" class="col-md-2 control-label text-info">
                RUC
            </label>
            <div class="col-md-4">
                <g:textField name="ruc" class='form-control required' maxlength="13" value="${proveedorInstance?.ruc}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="tipo" class="col-md-2 control-label text-info">
                Tipo
            </label>
            <div class="col-md-4">
                <g:select name="tipo" from="${['N': 'Natural', 'J': 'Jurídica', 'E': 'Empresa del Estado']}" class="form-control"  value="${proveedorInstance?.tipo}" optionValue="value" optionKey="key"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <div class="col-md-8">
                <g:textField name="nombre" class='form-control required' maxlength="63" value="${proveedorInstance?.nombre}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <div class="col-md-8">
                <g:textField name="direccion" class='form-control' maxlength="60" value="${proveedorInstance?.direccion}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'telefonos', 'error')} ${hasErrors(bean: proveedorInstance, field: 'email', 'error')} ">
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <div class="col-md-4">
                <g:textField name="telefono" class='form-control digits' maxlength="40" value="${proveedorInstance?.telefonos}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="email" class="col-md-2 control-label text-info">
                Email
            </label>
            <div class="col-md-4">
                <g:textField name="email" class='form-control email' maxlength="40" value="${proveedorInstance?.email}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombreContacto', 'error')} ${hasErrors(bean: proveedorInstance, field: 'apellidoContacto', 'error')} ">
        <span class="grupo">
            <label for="nombreContacto" class="col-md-2 control-label text-info">
                Nombre Contacto
            </label>
            <div class="col-md-4">
                <g:textField name="nombreContacto" class='form-control' maxlength="31" value="${proveedorInstance?.nombreContacto}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="apellidoContacto" class="col-md-2 control-label text-info">
                Apellido Contacto
            </label>
            <div class="col-md-4">
                <g:textField name="apellidoContacto" class='form-control' maxlength="31" value="${proveedorInstance?.apellidoContacto}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'licencia', 'error')} ${hasErrors(bean: proveedorInstance, field: 'camara', 'error')} ">
        <span class="grupo">
            <label for="licencia" class="col-md-2 control-label text-info">
                Licencia profesional del colegio de ingenieros
            </label>
            <div class="col-md-4">
                <g:textField name="licencia" class='form-control' maxlength="10" value="${proveedorInstance?.licencia}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="camara" class="col-md-2 control-label text-info">
                Registro en la cámara de la construcción
            </label>
            <div class="col-md-4">
                <g:textField name="camara" class='form-control' maxlength="7" value="${proveedorInstance?.camara}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'estado', 'error')} ${hasErrors(bean: proveedorInstance, field: 'titulo', 'error')} ">
        <span class="grupo">
            <label for="estado" class="col-md-2 control-label text-info">
                Estado
            </label>
            <div class="col-md-4">
                <g:select name="estado" from="${['1':'Activo', '0': 'Inactivo']}" optionKey="key" optionValue="value" class="form-control"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="titulo" class="col-md-2 control-label text-info">
                Título Profesional del Titular
            </label>
            <div class="col-md-4">
                <g:textField name="titulo" class='form-control' maxlength="4" value="${proveedorInstance?.titulo}" />
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">


    // var select = document.getElementById('estadoId');
    // select.onchange = function () {
    //     if(this.options[this.selectedIndex].value == '1'){
    //         select.className = this.options[this.selectedIndex].className='greenText';
    //     }else{
    //         select.className = this.options[this.selectedIndex].className='redText';
    //     }
    // };

    cargarCanton($("#provinciaId").val());

    $("#provinciaId").change(function () {
        var id = $(this).val();
        cargarCanton(id);
    });

    function cargarCanton(provincia) {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proveedor', action: 'canton_ajax')}',
            data:{
                provincia:provincia,
                id: '${proveedorInstance?.id}'
            },
            success: function (msg) {
                $("#divCanton").html(msg)
            }
        });
    }

    var validator = $("#frmSaveProveedor").validate({
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
