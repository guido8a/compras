<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 14/10/19
  Time: 12:06
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
        <g:each in="${lista}" var="administracion" status="z">
            <tr data-id="${administracion.id}">
                <td style="width: 35%">
                    ${administracion?.nombrePrefecto}
                </td>
                <td style="width: 35%">
                    ${administracion?.descripcion}
                </td>
                <td style="width: 15%">
                    ${administracion?.fechaInicio?.format("dd-MM-yyyy")}
                </td>
                <td style="width: 15%">
                    ${administracion?.fechaFin?.format("dd-MM-yyyy")}
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
