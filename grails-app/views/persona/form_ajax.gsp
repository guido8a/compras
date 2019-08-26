<%@ page import="seguridad.Departamento; seguridad.Prfl; seguridad.Persona" %>

%{--<asset:javascript src="/jquery/ui.js"/>--}%
<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPersona" role="form" action="save_ajax" method="POST">
            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'sexo', 'error')} ${hasErrors(bean: personaInstance, field: 'sexo', 'error')} required">
            <g:hiddenField name="id" value="${personaInstance?.id}"/>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="login" class="col-md-4 control-label">
                        Usuario
                    </label>
                </span>
                <div class="col-md-8">
                    <g:textField name="login" maxlength="15" class="form-control input-sm unique noEspacios required" value="${personaInstance?.login}" style="width: 160px"/>
                </div>
            </div>

            <div class="col-md-6">
                    <span class="grupo">
                        <label for="sexo" class="col-md-4 control-label">
                            Sexo
                        </label>

                        <div class="col-md-8">
                            <g:select name="sexo" from="${['F': 'Femenino', 'M': 'Masculino']}" required="" optionKey="key" optionValue="value"
                                      class="form-control input-sm required" value="${personaInstance?.sexo}"/>
                        </div>
                    </span>
                </div>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} required">
                <div class="col-md-6">
                    <span class="grupo">
                        <label for="nombre" class="col-md-4 control-label">
                            Nombre
                        </label>

                        <div class="col-md-8">
                            <g:textField name="nombre" maxlength="40" required="" class="form-control input-sm required" value="${personaInstance?.nombre}"/>
                        </div>
                    </span>
                </div>

                <div class="col-md-6">
                    <span class="grupo">
                        <label for="apellido" class="col-md-4 control-label">
                            Apellido
                        </label>

                        <div class="col-md-8">
                            <g:textField name="apellido" maxlength="40" required="" class="form-control input-sm required" value="${personaInstance?.apellido}"/>
                        </div>
                    </span>
                </div>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'mail', 'error')} ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
                <div class="col-md-6">
                    <span class="grupo">
                        <label for="mail" class="col-md-4 control-label">
                            E-mail
                        </label>

                        <div class="col-md-8">
                            <div class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-envelope"></i>
                            </span><g:field type="email" name="mail" maxlength="40" class="form-control input-sm unique noEspacios required" value="${personaInstance?.mail}"/>
                            </div>
                        </div>
                    </span>
                </div>

                <div class="col-md-6">
                    <span class="grupo">
                        <label for="telefono" class="col-md-4 control-label">
                            Teléfono
                        </label>

                        <div class="col-md-8">
                            <g:textField name="telefono" maxlength="10" class="form-control input-sm required" value="${personaInstance?.telefono}"/>
                        </div>

                    </span>
                </div>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'departamento', 'error')} ${hasErrors(bean: personaInstance, field: 'cargoPersonal', 'error')}">
                <div class="col-md-12">
                    <span class="grupo">
                        <label for="departamento" class="col-md-2 control-label">
                            Departamento
                        </label>

                        <div class="col-md-10">
                            <g:select id="departamento" name="departamento.id" from="${Departamento.list([sort:'nombre'])}" optionKey="id" value="${departamento ? departamento?.id : personaInstance?.departamento?.id}" class="many-to-one form-control input-sm" noSelection="['null': '']"/>
                        </div>

                    </span>
                </div>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">

                <div class="col-md-12 ">
                    <span class="grupo">
                        <label for="cargo" class="col-md-2 control-label">
                            Cargo
                        </label>

                        <div class="col-md-10">
                            <g:textArea name="cargo" cols="80" rows="1" maxlength="250" class="form-control input-sm" value="${personaInstance?.cargo}" style="resize: none"/>
                        </div>

                    </span>
                </div>
            </div>


            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'login', 'error')} ${hasErrors(bean: personaInstance, field: 'sigla', 'error')}">
                <div class="col-md-12">
                    <span class="grupo">

                        <label for="sigla" class="col-md-2 control-label">
                            Sigla
                        </label>

                        <div class="col-md-2">
                            <g:textField name="sigla" maxlength="8" class="form-control input-sm" value="${personaInstance?.sigla}"/>
                        </div>


                        <label for="activo" class="col-md-2 control-label">
                            Activo
                        </label>

                        <div class="col-md-2">
                            <g:select name="activo" value="${personaInstance.activo}" class="form-control input-sm required" required=""
                                      from="${[1: 'Sí', 0: 'No']}" optionKey="key" optionValue="value"/>
                        </div>
                    </span>
                </div>

            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'perfil', 'error')} ">
                <div class="col-md-12">
                    <span class="grupo">
                        <label for="perfil" class="col-md-2 control-label">
                            Perfiles
                        </label>

                        <div class="col-md-10">
                            <div class="row">
                                    <div class="col-md-8">
                                        <g:select name="perfil" from="${Prfl.list([sort: 'nombre'])}" class="form-control input-sm"
                                                  optionKey="id" optionValue="nombre"/>
                                    </div>

                                    <div class="col-md-2">
                                        <a href="#" class="btn btn-success btn-sm" id="btn-addPerfil" title="Agregar perfil">
                                            <i class="fa fa-plus"></i> Agregar perfil
                                        </a>
                                    </div>
                            </div>

                            <div class="row" style="margin-top: 5px">
                                <div class="col-md-6">
                                    <table id="tblPerfiles" class="table table-hover table-bordered table-condensed">
                                        <g:each in="${perfiles.perfil}" var="perfil">
                                            <tr class="perfiles" data-id="${perfil.id}">
                                                <td>
                                                    ${perfil?.nombre}
                                                </td>
                                                <td width="35">
                                                    <a href="#" class="btn btn-danger btn-xs btn-deletePerfil">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </g:each>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </span>
                </div>
            </div>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmPersona").validate({
            errorClass    : "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success       : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            },
            rules         : {
                mail : {
                    remote: {
                        url : "${createLink(action: 'validarMail_ajax')}",
                        type: "post",
                        data: {
                            id: "${personaInstance?.id}"
                        }
                    }
                },
                login: {
                    remote: {
                        url : "${createLink(action: 'validarLogin_ajax')}",
                        type: "post",
                        data: {
                            id: "${personaInstance?.id}"
                        }
                    }
                }
            },
            messages      : {
                mail : {
                    remote: "Ya existe Mail"
                },
                login: {
                    remote: "Ya existe Login"
                }
            }
        });

        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormPersona();
                return false;
            }
            return true;
        });

        $("#btn-addPerfil").click(function () {
            var $perfil = $("#perfil");
            var idPerfilAdd = $perfil.val();
            $(".perfiles").each(function () {
                if ($(this).data("id") == idPerfilAdd) {
                    $(this).remove();
                }
            });
            var $tabla = $("#tblPerfiles");

            var $tr = $("<tr>");
            $tr.addClass("perfiles");
            $tr.data("id", idPerfilAdd);
            var $tdNombre = $("<td>");
            $tdNombre.text($perfil.find("option:selected").text());
            var $tdBtn = $("<td>");
            $tdBtn.attr("width", "35");
            var $btnDelete = $("<a>");
            $btnDelete.addClass("btn btn-danger btn-xs");
            $btnDelete.html("<i class='fa fa-trash-o'></i> ");
            $tdBtn.append($btnDelete);

            $btnDelete.click(function () {
                $tr.remove();
                return false;
            });

            $tr.append($tdNombre).append($tdBtn);

            $tabla.prepend($tr);
            $tr.effect("highlight");

            return false;
        });

        $(".btn-deletePerfil").click(function () {
            $(this).parents("tr").remove();
            return false;
        });

    </script>

</g:else>