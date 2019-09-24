<%@ page import="compras.DepartamentoItem" %>


    <form class="form-horizontal">
        <g:if test="${departamentoItemInstance?.descripcion}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">DESCRIPCIÓN</td>
                        <td style="width: 65%" class="alert-success">${departamentoItemInstance?.descripcion}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${departamentoItemInstance?.codigo}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">CÓDIGO</td>
                        <td style="width: 65%" class="alert-success"> ${departamentoItemInstance?.subgrupo?.codigo?.toString()?.padLeft(3,'0')}.${departamentoItemInstance?.codigo?.toString()?.padLeft(3,'0')}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${departamentoItemInstance?.subgrupo}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">GRUPO</td>
                        <td style="width: 65%" class="alert-success"> ${departamentoItemInstance?.subgrupo?.descripcion}</td>
                    </tr>
                </table>
            </div>
        </g:if>
        <g:if test="${departamentoItemInstance?.transporte}">
            <div class="control-group">
                <table class="table-bordered table-condensed table-hover" width="100%">
                    <tr>
                        <td style="width: 35%" class="alert-warning">TRANSPORTE</td>
                        <td style="width: 65%" class="alert-success"> ${departamentoItemInstance?.transporte?.descripcion ?: ''}</td>
                    </tr>
                </table>
            </div>
        </g:if>
    </form>

