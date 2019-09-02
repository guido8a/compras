<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 8:45
--%>


<%@ page import="compras.Comunidad" %>

<style type="text/css">
.tama {
    font-size: 14px;
}
</style>

<div id="show-comunidad" class="span5 tama" role="main">

    <form class="form-horizontal">

        <g:if test="${comunidadInstance?.parroquia}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Parroquia
                </div>
                <div class="col-md-3">
                    ${comunidadInstance?.parroquia?.nombre}
                </div>
            </div>
        </g:if>

        <g:if test="${comunidadInstance?.numero}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Código
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${comunidadInstance}" field="numero"/>
                </div>
            </div>
        </g:if>

        <g:if test="${comunidadInstance?.nombre}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Nombre
                </div>
                <div class="col-md-6">
                    <g:fieldValue bean="${comunidadInstance}" field="nombre"/>
                </div>
            </div>
        </g:if>

        <g:if test="${comunidadInstance?.latitud}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Latitud
                </div>
                <div class="col-md-3">
                    <g:fieldValue bean="${comunidadInstance}" field="latitud"/>
                </div>
            </div>
        </g:if>

        <g:if test="${comunidadInstance?.longitud}">
            <div class="row">
                <div class="col-md-2 text-info">
                    Longitud
                </div>
                <div class="col-md-3">
            <g:fieldValue bean="${comunidadInstance}" field="longitud"/>
            </div>
        </g:if>

    </form>
</div>
