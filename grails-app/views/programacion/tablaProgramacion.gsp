<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/19
  Time: 9:19
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

.alinear {
    text-align: center;
}
</style>

<div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${lista}" var="programacion" status="z">
            <tr data-id="${programacion.id}">
                <td style="width: 70%">
                    ${programacion?.descripcion}
                </td>
                <td style="width: 15%" class="alinear">
                    <div  style="color: ${programacion?.fechaInicio ?: '#e1a628'}"> ${programacion?.fechaInicio?.format("dd-MM-yyyy") ?: '- Sin Fecha -'} </div>
                </td>
                <td style="width: 15%" class="alinear">
                   <div  style="color: ${programacion?.fechaFin ?: '#e1a628'}"> ${programacion?.fechaFin?.format("dd-MM-yyyy") ?: '- Sin Fecha -'} </div>
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
