<%@ page import="compras.Grupo" %>


<form class="form-horizontal">
    <g:if test="${grupoInstance?.descripcion}">
        <div class="control-group">
            <table class="table-bordered table-condensed table-hover" width="100%">
                <tr>
                    <td style="width: 35%" class="alert-warning">DESCRIPCIÓN</td>
                    <td style="width: 65%" class="alert-success">${grupoInstance?.descripcion}</td>
                </tr>
            </table>
        </div>
    </g:if>
%{--    <g:if test="${grupoInstance?.codigo}">--}%
%{--        <div class="control-group">--}%
%{--            <table class="table-bordered table-condensed table-hover" width="100%">--}%
%{--                <tr>--}%
%{--                    <td style="width: 35%" class="alert-warning">CÓDIGO</td>--}%
%{--                    <td style="width: 65%" class="alert-success">${grupoInstance?.codigo?.toString().padLeft(3,'0')}</td>--}%
%{--                </tr>--}%
%{--            </table>--}%
%{--        </div>--}%
%{--    </g:if>--}%
</form>
