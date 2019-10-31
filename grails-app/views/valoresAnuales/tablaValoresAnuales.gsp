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
        <g:each in="${lista}" var="valor" status="z">
            <tr data-id="${valor.id}">
                <td style="width: 20%">
                    ${valor?.anio?.anio}
                </td>
                <td style="width: 10%">
                    ${valor?.sueldoBasicoUnificado}
                </td>
                <td style="width: 10%">
                    ${valor?.seguro}
                </td>
                <td style="width: 10%">
                    ${valor?.tasaInteresAnual}
                </td>
                <td style="width: 10%">
                    ${valor?.factorCostoRepuestosReparaciones}
                </td>
                <td style="width: 10%">
                    ${valor?.inflacion}
                </td>
                <td style="width: 10%">
                    ${valor?.costoDiesel}
                </td>
                <td style="width: 10%">
                    ${valor?.costoGrasa}
                </td>
                <td style="width: 10%">
                    ${valor?.costoLubricante}
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
