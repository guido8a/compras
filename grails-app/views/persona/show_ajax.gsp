<%@ page import="seguridad.Persona" %>

<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:if test="${personaInstance?.nombre || personaInstance?.apellido}">
            <div class="row">
                <div class="col-md-2 show-label">
                    Nombre
                </div>

                <div class="col-md-4 text-info">
                    <g:fieldValue bean="${personaInstance}" field="nombre"/>
                </div>

                <div class="col-md-2 show-label">
                    Apellido
                </div>

                <div class="col-md-4 text-info">
                    <g:fieldValue bean="${personaInstance}" field="apellido"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.sexo}">
            <div class="row">
                <div class="col-md-2 show-label">
                    Sexo
                </div>

                <div class="col-md-4  text-info">
                    ${personaInstance.sexo == "M" ? "Masculino" : "Femenino"}
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.telefono}">
            <div class="row">
                <div class="col-md-2 show-label">
                    Teléfono
                </div>

                <div class="col-md-4 text-info">
                    <g:fieldValue bean="${personaInstance}" field="telefono"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.mail}">
            <div class="row">
                <div class="col-md-2 show-label">
                    E-mail
                </div>

                <div class="col-md-4  text-info">
                    <g:fieldValue bean="${personaInstance}" field="mail"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.departamento || personaInstance?.cargo}">
            <div class="row">
                <div class="col-md-2 show-label">
                    Departamento
                </div>

                <div class="col-md-4 text-info">
                    ${personaInstance?.departamento?.encodeAsHTML()}
                </div>

                <div class="col-md-2 show-label">
                    Cargo
                </div>

                <div class="col-md-4 text-info">
                    %{--${personaInstance?.cargoPersonal?.encodeAsHTML()}--}%
                    ${personaInstance?.cargo ?: ''}
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.login || personaInstance?.sigla}">
            <div class="row">
                <div class="col-md-2 show-label">
                    Usuario
                </div>

                <div class="col-md-4 text-info">
                    <g:fieldValue bean="${personaInstance}" field="login"/>
                </div>

                <div class="col-md-2 show-label">
                    Sigla
                </div>

                <div class="col-md-4 text-info">
                    <g:fieldValue bean="${personaInstance}" field="sigla"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.estaActivo}">
            <div class="row">
                <div class="col-md-2 show-label">
                    Activo
                </div>

                <div class="col-md-4 text-info">
                    ${personaInstance.estaActivo == 1 ? "Sí" : "No"}
                </div>

            </div>
        </g:if>

        <g:if test="${perfiles.size() > 0}">
            <div class="row">
                <div class="col-md-2 show-label">
                    Perfiles
                </div>

                <div class="col-md-10 text-info">
                    <ul>
                        <g:each in="${perfiles.perfil}" var="perfil">
                            <li>${perfil.nombre}</li>
                        </g:each>
                    </ul>
                </div>

            </div>
        </g:if>
    </div>
</g:else>