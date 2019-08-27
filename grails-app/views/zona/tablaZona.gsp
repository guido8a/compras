<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/08/19
  Time: 9:31
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/07/19
  Time: 12:10
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

%{--<g:set var="clase" value="${'principal'}"/>--}%

<div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${lista}" var="zona" status="z">

            <tr id="${lista.id}" data-id="${lista.id}">
                <td style="width: 15%">
                    ${zona?.numero}
                </td>
                <td style="width: 35%">
                    ${zona?.nombre}
                </td>
                <td style="width: 25%">
                    ${zona?.latitud}
                </td>
                <td style="width: 25%">
                    ${zona?.longitud}
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
