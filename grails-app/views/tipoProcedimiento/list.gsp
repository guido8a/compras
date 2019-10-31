<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 12:41
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Tipo de Procedimiento</title>

    <style type="text/css">

    .alinear {
        text-align: center !important;
    }

    #buscar {
        width: 400px;
        border-color: #0c6cc2;
    }
    </style>

</head>

<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">

    <div class="btn-group">
        <g:link controller="parametros" action="list" class="btn btn-info">
            <i class="fa fa-arrow-left"></i> Parámetros
        </g:link>
    </div>

    <div class="btn-group">
        <a href="#" class="btn btn-primary btnCrear">
            <i class="fa fa-file"></i> Nuevo Tipo
        </a>
    </div>

</div>

<div style="margin-top: 30px; min-height: 430px" class="vertical-container">
    <p class="css-vertical-text">Tipo de Procedimiento</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 25%">Descripción</th>
            <th class="alinear" style="width: 10%">Sigla</th>
            <th class="alinear" style="width: 10%">Fuente</th>
            <th class="alinear" style="width: 10%">Costos Base</th>
            <th class="alinear" style="width: 15%">Techo</th>
            <th class="alinear" style="width: 10%">Preparatorio (d)</th>
            <th class="alinear" style="width: 10%">Precontractual (d)</th>
            <th class="alinear" style="width: 10%">Contractual (d)</th>
        </tr>
        </thead>
    </table>

    <div id="tablaTipoProcedimiento">
    </div>
</div>

<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditTipoProcedimiento(null)
    });

    cargarTablaTipoProcedimiento();

    function cargarTablaTipoProcedimiento (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'tipoProcedimiento', action: 'tablaTipoProcedimiento')}',
            data:{
            },
            success: function (msg) {
                $("#tablaTipoProcedimiento").html(msg)
            }
        });
    }

    function createEditTipoProcedimiento(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'tipoProcedimiento', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditTipoProcedimiento",
                    title : title + " Tipo de Procedimiento",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormTipoProcedimiento();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function submitFormTipoProcedimiento() {
        var $form = $("#frmSaveTipoProcedimiento");
        var $btn = $("#dlgCreateEditTipoProcedimiento").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log(parts[1], "success");
                        setTimeout(function () {
                            cargarTablaTipoProcedimiento()
                        }, 1000);
                    }else{
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    function createContextMenu(node) {
        var $tr = $(node);
        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var id = $tr.data("id");

        var editar = {
            label: 'Editar',
            icon: "fa fa-pen text-info",
            action : function () {
                createEditTipoProcedimiento(id);
            }
        };

        var borrarTipoProcedimiento= {
            label            : "Borrar",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Tipo de Procedimiento",
                    message: "Está seguro de borrar esta Tipo de Procedimiento? Esta acción no puede deshacerse.",
                    buttons: {
                        cancel: {
                            label: '<i class="fa fa-times"></i> Cancelar',
                            className: 'btn-primary'
                        },
                        confirm: {
                            label: '<i class="fa fa-trash"></i> Borrar',
                            className: 'btn-danger'
                        }
                    },
                    callback: function (result) {
                        if(result){
                            var dialog = cargarLoader("Borrando...");
                            $.ajax({
                                type: 'POST',
                                url: '${createLink(controller: 'tipoProcedimiento', action: 'borrarTipoProcedimiento_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Tipo de Procedimiento borrado correctamente","success");
                                        setTimeout(function () {
                                            cargarTablaTipoProcedimiento();
                                        }, 1000);
                                    }else{
                                        log("Error al borrar el Tipo de Procedimiento", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarTipoProcedimiento;

        return items
    }
</script>

</body>
</html>
