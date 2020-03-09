<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/11/19
  Time: 15:12
--%>



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
        <g:each in="${lista}" var="item" status="z">
            <tr data-id="${item.item__id}">
                <td style="width: 25%">
                    ${item?.itemcdgo}
                </td>
                <td style="width: 55%">
                    ${item?.itemnmbr}
                </td>
                <td style="width: 15%">
                    ${item?.undddscr}
                </td>
                <td style="width: 6%">
                    <a href="#" class="btn btn-success btn-sm btnSeleccionar" data-id="${item.item__id}" data-nombre="${item.itemnmbr}" data-codigo="${item.itemcdgo}"><i class="fa fa-check"></i> </a>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">


    $(".btnSeleccionar").click(function () {
        var id = $(this).data("id");
        var nom = $(this).data("nombre");
        var cod = $(this).data("codigo");
        $("#nombre").val(nom);
        $("#codigo").val(cod);
        $("#item").val(id);
        $('.bootbox.modal').modal('hide');
    });


</script>