
<%@ page import="compras.Canton" %>

<style type="text/css">
 .tama {
    font-size: 14px;
}
</style>

<div id="show-canton" class="span5 tama" role="main">

    <form class="form-horizontal">

        <g:if test="${cantonInstance?.provincia}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Provincia
                </div>
                <div class="col-md-3">
                    ${cantonInstance?.provincia?.nombre}
                </div>
            </div>
        </g:if>

        <g:if test="${cantonInstance?.numero}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Número
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${cantonInstance}" field="numero"/>
                </div>
            </div>
        </g:if>

        <g:if test="${cantonInstance?.nombre}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Nombre
                </div>
                <div class="col-md-6">
                    <g:fieldValue bean="${cantonInstance}" field="nombre"/>
                </div>
            </div>
        </g:if>

        <g:if test="${cantonInstance?.latitud}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Latitud
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${cantonInstance}" field="latitud"/>
                </div>
            </div>
        </g:if>

        <g:if test="${cantonInstance?.longitud}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Longitud
                </div>
                <div class="col-md-3">
            <g:fieldValue bean="${cantonInstance}" field="longitud"/>
            </div>
        </g:if>

    </form>
</div>
