<%@ page import="seguridad.Departamento" %>

<g:if test="${!departamentoInstance}">
    <elm:notFound elem="Departamento" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:if test="${departamentoInstance?.nombre}">
            <div class="row">
                <div class="col-md-3  show-label">
                    Nombre
                </div>

                <div class="col-md-9 text-info">
                    <g:fieldValue bean="${departamentoInstance}" field="nombre"/>
                </div>

            </div>
        </g:if>

        <g:if test="${departamentoInstance?.padre}">
            <div class="row">
                <div class="col-md-3  show-label">
                    Depende de
                </div>

                <div class="col-md-9 text-info">
                    ${departamentoInstance?.padre?.encodeAsHTML()}
                </div>

            </div>
        </g:if>

        <g:if test="${departamentoInstance?.orden}">
            <div class="row">
                <div class="col-md-3  show-label">
                    Orden
                </div>

                <div class="col-md-9 text-info">
                    <g:fieldValue bean="${departamentoInstance}" field="orden"/>
                </div>

            </div>
        </g:if>

        <g:if test="${departamentoInstance?.codigo}">
            <div class="row">
                <div class="col-md-3  show-label">
                    Código
                </div>

                <div class="col-md-9 text-info">
                    <g:fieldValue bean="${departamentoInstance}" field="codigo"/>
                </div>

            </div>
        </g:if>

        <g:if test="${departamentoInstance?.direccion}">
            <div class="row">
                <div class="col-md-3  show-label">
                    Ubicación
                </div>

                <div class="col-md-9 text-info">
                    <g:fieldValue bean="${departamentoInstance}" field="direccion"/>
                </div>

            </div>
        </g:if>

        <g:if test="${departamentoInstance?.telefono}">
            <div class="row">
                <div class="col-md-3  show-label">
                    Teléfono
                </div>

                <div class="col-md-9 text-info">
                    <g:fieldValue bean="${departamentoInstance}" field="telefono"/>
                </div>

            </div>
        </g:if>


    </div>

</g:else>