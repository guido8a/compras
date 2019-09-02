
<%@ page import="compras.Provincia" %>

<style type="text/css">
 .tama {
    font-size: 14px;
}
</style>

<div id="show-provincia" class="span5 tama" role="main">

    <form class="form-horizontal">

        <g:if test="${provinciaInstance?.numero}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Número
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${provinciaInstance}" field="numero"/>
                </div>
            </div>
        </g:if>

        <g:if test="${provinciaInstance?.nombre}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Nombre
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${provinciaInstance}" field="nombre"/>
                </div>
            </div>
        </g:if>

        <g:if test="${provinciaInstance?.latitud}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Latitud
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${provinciaInstance}" field="latitud"/>
                </div>
            </div>
        </g:if>

        <g:if test="${provinciaInstance?.longitud}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Longitud
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${provinciaInstance}" field="longitud"/>
                </div>
            </div>
        </g:if>
    </form>
</div>
