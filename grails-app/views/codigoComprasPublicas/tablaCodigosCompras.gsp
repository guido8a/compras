<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 09/09/19
  Time: 14:28
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

<g:set var="clase" value="${'principal'}"/>

<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" width="100%">
        <g:each in="${lista}" var="item" status="z">
            <tr class="${clase}">
                <td width="15%">
                    ${item?.cpacnmro}
                </td>
                <td width="75%">
                    ${item?.cpacdscr}
                </td>
                <td width="10%" style="text-align: center">
                    <a href="#" class="btn btn-success btn-sm btnCodigoSel" data-id="${item.cpac__id}" data-nombre="${item?.cpacdscr}" data-cod="${item?.cpacnmro}" title="Seleccionar">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnCodigoSel").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");
        var codigo = $(this).data("cod");

        if(${tipo == '1'}){
            $("#codigoComprasPublicas").val(id);
            $("#codigoComprasPublicasNombre").val(codigo + " - " + nombre);
            var dialog = $("#dlgTablaCPC");
            dialog.modal('hide');
            $(".dlgCreateEditItem").modal('hide')
        }else{
            $("#codigoComprasPublicas").val(id);
            $("#categoriaCPC").val(codigo + " - " + nombre);
            $('.bootbox.modal').modal('hide')
        }




    });

</script>

