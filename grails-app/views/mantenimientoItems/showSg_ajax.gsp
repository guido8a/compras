<%@ page import="compras.SubgrupoItems" %>



<form class="form-horizontal">
    <g:if test="${subgrupoItemsInstance?.descripcion}">
        <div class="control-group">
            <table class="table-bordered table-condensed table-hover" width="100%">
                <tr>
                    <td style="width: 35%" class="alert-warning">DESCRIPCIÓN</td>
                    <td style="width: 65%" class="alert-success">${subgrupoItemsInstance?.descripcion}</td>
                </tr>
            </table>
        </div>
    </g:if>
    <g:if test="${subgrupoItemsInstance?.codigo}">
        <div class="control-group">
            <table class="table-bordered table-condensed table-hover" width="100%">
                <tr>
                    <td style="width: 35%" class="alert-warning">CÓDIGO</td>
                    <td style="width: 65%" class="alert-success"> ${subgrupoItemsInstance?.codigo?.toString().padLeft(3,'0')}</td>
                </tr>
            </table>
        </div>
    </g:if>
</form>

