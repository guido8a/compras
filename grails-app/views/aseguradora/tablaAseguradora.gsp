<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:14
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
</style>

<div class="" style="width: 99.7%;height: 360px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${lista}" var="aseguradora" status="z">
            <tr data-id="${aseguradora.id}">
                <td style="width: 10%">
                    ${aseguradora?.tipo?.descripcion}
                </td>
                <td style="width: 25%">
                    ${aseguradora?.nombre}
                </td>
                <td style="width: 25%">
                    ${aseguradora?.direccion}
                </td>
                <td style="width: 15%">
                    ${aseguradora?.responsable}
                </td>
                <td style="width: 10%">
                    ${aseguradora?.telefonos}
                </td>
                <td style="width: 15%">
                    ${aseguradora?.mail}
                </td>
            </tr>
        </g:each>
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
