
<%@ page import="bitacora.Actividad" %>

<g:if test="${!actividadInstance}">
    <elm:notFound elem="Actividad" genero="o" />
</g:if>
<g:else>

    <g:if test="${actividadInstance?.padre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Actividad Principal
            </div>
            
            <div class="col-md-10">
                ${actividadInstance?.padre?.descripcion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-10">
                <g:fieldValue bean="${actividadInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.fechaInicio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha de Inicio
            </div>
            
            <div class="col-md-9">
                <g:formatDate date="${actividadInstance?.fechaInicio}" format="dd-MM-yyyy HH:mm" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.fechaFin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha de Fin
            </div>
            
            <div class="col-md-9">
                <g:formatDate date="${actividadInstance?.fechaFin}" format="dd-MM-yyyy HH:mm" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.horas}">
        <div class="row">
            <div class="col-md-2 text-info">
                Horas
            </div>
            
            <div class="col-md-9">
                <g:fieldValue bean="${actividadInstance}" field="horas"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.tiempo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tiempo real
            </div>
            
            <div class="col-md-9">
                <g:fieldValue bean="${actividadInstance}" field="tiempo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.ingresa}">
        <div class="row">
            <div class="col-md-2 text-info">
                Ingresado por
            </div>
            
            <div class="col-md-9">
                ${actividadInstance?.ingresa?.nombre} ${actividadInstance?.ingresa?.apellido}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.responsable}">
        <div class="row">
            <div class="col-md-2 text-info">
                Responsable
            </div>
            
            <div class="col-md-9">
                ${actividadInstance?.responsable?.nombre} ${actividadInstance?.responsable?.apellido}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.prioridad}">
        <div class="row">
            <div class="col-md-2 text-info">
                Prioridad
            </div>
            
            <div class="col-md-9">
                ${actividadInstance?.prioridad?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.como}">
        <div class="row">
            <div class="col-md-2 text-info">
                Como realizar
            </div>
            
            <div class="col-md-9">
                <g:fieldValue bean="${actividadInstance}" field="como"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${actividadInstance?.avance}">
        <div class="row">
            <div class="col-md-2 text-info">
                Avance actual
            </div>
            
            <div class="col-md-9">
                <g:fieldValue bean="${actividadInstance}" field="avance"/>
            </div>
            
        </div>
    </g:if>

    <g:if test="${actividadInstance?.fechaRegistro}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha de Registro
            </div>

            <div class="col-md-9">
                <g:formatDate date="${actividadInstance?.fechaRegistro}" format="dd-MM-yyyy" />
            </div>

        </div>
    </g:if>

    <g:if test="${actividadInstance?.observaciones}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observaciones
            </div>
            
            <div class="col-md-10">
                <g:fieldValue bean="${actividadInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    

</g:else>