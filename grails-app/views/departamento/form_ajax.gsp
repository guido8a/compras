<%@ page import="seguridad.Departamento" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%

<g:if test="${!departamentoInstance}">
    <elm:notFound elem="Departamento" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmDepartamento" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${departamentoInstance?.id}"/>

            <div class="form-group keeptogether ${hasErrors(bean: departamentoInstance, field: 'nombre', 'error')} required">
                <span class="grupo">
                    <label for="nombre" class="col-md-2 control-label">
                        Nombre
                    </label>

                    <div class="col-md-10">
                        <g:textField name="nombre" maxlength="127" required="" class="form-control input-sm required" value="${departamentoInstance?.nombre}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: departamentoInstance, field: 'padre', 'error')} ">
                <span class="grupo">
                    <label for="padre" class="col-md-2 control-label">
                        Depende de
                    </label>

                    <div class="col-md-4">
                        <g:select id="padre" name="padre.id" from="${seguridad.Departamento.list()}" optionKey="id"
                                  value="${departamentoInstance?.padre?.id}" class="many-to-one form-control input-sm"
                                  noSelection="['null': '']"/>
                    </div>

                </span>
                <span class="grupo">
                    <label for="orden" class="col-md-1 control-label" style="margin-left: 30px">
                        Orden
                    </label>

                    <div class="col-md-1">
                        <g:field name="orden" type="number" min="0"  step="1" value="${departamentoInstance.orden}"
                                 class="digits form-control input-sm required" required="" style="width: 60px;" />
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: departamentoInstance, field: 'direccion', 'error')} ">
                <span class="grupo">
                    <label for="direccion" class="col-md-2 control-label">
                        Ubicación
                    </label>

                    <div class="col-md-10">
                        <g:textArea name="direccion" maxlength="127" class="form-control input-sm" value="${departamentoInstance?.direccion}"
                                    style="height: 40px; resize: none"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: departamentoInstance, field: 'telefono', 'error')} ${hasErrors(bean: departamentoInstance, field: 'fax', 'error')} ">
                <div class="col-md-6">
                    <span class="grupo">
                        <label for="telefono" class="col-md-4 control-label">
                            Teléfono
                        </label>

                        <div class="col-md-8">
                            <g:textField name="telefono" maxlength="63" class="form-control input-sm" value="${departamentoInstance?.telefono}"/>
                        </div>

                    </span>
                </div>

                <div class="col-md-3">
                    <span class="grupo">
                        <label for="codigo" class="col-md-1 control-label">
                            Ext.
                        </label>

                        <div class="col-md-2">
                            <g:textField name="extension" maxlength="5" class="form-control input-sm unique noEspacios allCaps"
                                         value="${departamentoInstance?.extension}" style="width: 50px"/>
                        </div>
                    </span>
                </div>
                <div class="col-md-3">
                    <span class="grupo">
                        <label for="codigo" class="col-md-1 control-label" style="margin-left: -50px;">
                            Código
                        </label>

                        <div class="col-md-2">
                            <g:textField name="codigo" maxlength="6" class="form-control input-sm unique noEspacios allCaps required"
                                         value="${departamentoInstance?.codigo}" style="width: 80px"/>
                        </div>
                    </span>
                </div>

            </div>

            <div class="form-group keeptogether ${hasErrors(bean: departamentoInstance, field: 'telefono',
                    'error')} ${hasErrors(bean: departamentoInstance, field: 'fax', 'error')} ">
                <div class="col-md-6">
                    <span class="grupo">
                        <label for="activo" class="col-md-4 control-label">
                            Activo
                        </label>

                        <div class="col-md-3">
                            <g:select name="activo" value="${departamentoInstance.activo}"
                                      class="form-control input-sm required" required=""
                                      from="${[1: 'Sí', 0: 'No']}" optionKey="key" optionValue="value"/>
                        </div>
                    </span>
                </div>
            </div>


        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmDepartamento").validate({
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
                label.remove();
            }, rules       : {
                codigo : {
                    remote : {
                        url  : "${createLink(action: 'validar_unique_codigo_ajax')}",
                        type : "post",
                        data : {
                            id : "${departamentoInstance?.id}"
                        }
                    }
                },
                email  : {
                    remote : {
                        url  : "${createLink(action: 'validar_unique_email_ajax')}",
                        type : "post",
                        data : {
                            id : "${departamentoInstance?.id}"
                        }
                    }
                }

            },
            messages       : {

                codigo : {
                    remote : "Ya existe Código"
                },

                email : {
                    remote : "Ya existe E-mail"
                }

            }

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormUnidad();
                return false;
            }
            return true;
        });
    </script>

</g:else>