<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 15/11/19
  Time: 9:57
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
        <g:each in="${lista}" var="proyecto" status="z">

            <tr data-id="${proyecto.proy__id}">
                <td style="width: 10%">
                    ${proyecto?.proycdgo}
                </td>
                <td style="width: 40%">
                    ${proyecto?.proynmbr}
                </td>
                <td style="width: 15%">
                    ${proyecto?.tpaddscr}
                </td>
                <td style="width: 15%">
                    ${proyecto?.tppydscr}
                </td>
                <td style="width: 15%">
                    ${proyecto?.cmndnmbr}
                </td>
                <td style="width: 5%">
                    <a href="#" class="btn btn-success btn-sm btnSeleccionar" data-id="${proyecto.proy__id}"><i class="fa fa-check"></i> </a>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">


    $(".btnSeleccionar").click(function () {
         var id = $(this).data("id")
        var dialog = cargarLoader("Cargando...");
        location.href="${createLink(controller: 'proyecto', action: 'registroProyecto')}?id=" + id
    });


</script>
