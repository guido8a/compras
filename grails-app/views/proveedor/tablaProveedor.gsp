<%@ page import="compras.Canton" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/19
  Time: 15:03
--%>


<asset:stylesheet src="/apli/lzm.context-0.5.css"/>
<asset:javascript src="/apli/lzm.context-0.5.js"/>


<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
    .verde{
        background-color: #78b665;
        font-weight: bold;
    }



</style>

<div class="" style="width: 99.7%;height: 360px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:if test="${data}">
            <g:each in="${data}" var="proveedor" status="z">
                <tr data-id="${proveedor.prve__id}">
                    <td style="width: 25%">
                        ${proveedor?.prvenmbr}
                    </td>
                    <td style="width: 10%">
                        ${proveedor?.prve_ruc}
                    </td>
                    <td style="width: 10%" class="alinear">
                        ${proveedor?.prvetipo == 'N' ? 'NATURAL' : proveedor?.prvetipo == 'J' ? 'JURIDICA' : 'EMPRESA DEL ESTADO'}
                    </td>
                    <td style="width: 10%">
                        ${proveedor?.prvetelf}
                    </td>
                    <td style="width: 22%">
                        ${proveedor?.prvenbct != 'null' ? proveedor?.prvenbct : '' + proveedor?.prveapct != 'null' ? proveedor?.prveapct : ''}
                    </td>
                    <td style="width: 15%" class="alinear">
                        ${compras.Canton.get(proveedor?.cntn__id)?.nombre ?: ''}
                    </td>
                    <td style="width: 8%" class="verde alinear">
                        ${proveedor?.prveetdo == '1' ? 'ACTIVO' : 'INACTIVO'}
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-danger" style="font-size: 12px; text-align: center"><i class="fa fa-exclamation-triangle text-danger fa-3x"></i> No existen registros que coincidan con su búsqueda</div>
        </g:else>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });
    });
</script>
