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
        <g:each in="${lista}" var="proforma" status="z">
            <tr data-id="${proforma.prfr__id}">
                <td style="width: 40%">
                    ${proforma?.prvenmbr}
                </td>
                <td style="width: 45%">
                    ${proforma?.prfrdscr}
                </td>
                <td style="width: 10%; text-align: center">
                    ${proforma?.prfrfcen?.format("dd-MM-yyyy")}
                </td>
                <td style="width: 5%">
                    <a href="#" class="btn btn-success btn-xs btnSeleccionarProforma" data-id="${proforma.prfr__id}"><i class="fa fa-check"></i> </a>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleccionarProforma").click(function () {
       var id = $(this).data("id");
        location.href="${createLink(controller: 'proforma', action: 'proforma')}?tipo=" + 1 +"&proyecto=" + '${proyecto?.id}' + "&id=" + id
    });

    // $(function () {
    //     $("tr").contextMenu({
    //         items  : createContextMenu,
    //         onShow : function ($element) {
    //             $element.addClass("trHighlight");
    //         },
    //         onHide : function ($element) {
    //             $(".trHighlight").removeClass("trHighlight");
    //         }
    //     });
    // });
</script>
