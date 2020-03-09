<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 06/11/19
  Time: 14:25
--%>

<div class="" style="width: 100%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${lista}" var="res" status="z">
            <tr>
                <td style="width: 23%">
                    ${res?.provnmbr}
                </td>
                <td style="width: 22%">
                    ${res?.cntnnmbr}
                </td>
                <td style="width: 23%">
                    ${res?.parrnmbr}
                </td>
                <td style="width: 24%">
                    ${res?.cmndnmbr}
                </td>
                <td style="width: 8%">
                    <a href="#" class="btn btn-success btn-sm btnSeleccion" data-id="${res?.cmnd__id}" data-prov="${res?.provnmbr}" data-can="${res?.cntnnmbr}" data-parr="${res?.parrnmbr}" data-comu="${res?.cmndnmbr}"><i class="fa fa-check"></i></a>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleccion").click(function () {
        $("#comunidad").val($(this).data("id"));
        // $("#provincia").val($(this).data("prov"));
        $("#canton").val($(this).data("can"));
        $("#parroquia").val($(this).data("parr"));
        $("#comunidad_name").val($(this).data("comu"));
        $('.bootbox.modal').modal('hide')
    })

</script>