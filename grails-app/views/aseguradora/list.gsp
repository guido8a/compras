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
    <title>Aseguradora</title>

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
            <i class="fa fa-file"></i> Nueva Aseguradora
        </a>
    </div>

</div>

<div style="margin-top: 30px; min-height: 430px" class="vertical-container">
    <p class="css-vertical-text">Aseguradora</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 10%">Tipo de Aseguradora</th>
            <th class="alinear" style="width: 25%">Nombre</th>
            <th class="alinear" style="width: 24%">Dirección</th>
            <th class="alinear" style="width: 15%">Responsable</th>
            <th class="alinear" style="width: 10%">Teléfono</th>
            <th class="alinear" style="width: 16%">Mail</th>
        </tr>
        </thead>
    </table>

    <div id="tablaAseguradora">
    </div>
</div>

<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditAseguradora(null)
    });

    cargarTablaAseguradora();

    function cargarTablaAseguradora (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'aseguradora', action: 'tablaAseguradora')}',
            data:{
            },
            success: function (msg) {
                $("#tablaAseguradora").html(msg)
            }
        });
    }

    function createEditAseguradora(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'aseguradora', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditAseguradora",
                    title : title + " Aseguradora",
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
                                return submitFormAseguradora();
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

    function submitFormAseguradora() {
        var $form = $("#frmSaveAseguradora");
        var $btn = $("#dlgCreateEditAseguradora").find("#btnSave");
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
                            cargarTablaAseguradora()
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
                createEditAseguradora(id);
            }
        };

        var borrarAseguradora= {
            label            : "Borrar",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Aseguradora",
                    message: "Está seguro de borrar esta Aseguradora? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'aseguradora', action: 'borrarAseguradora_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Aseguradora borrada correctamente","success");
                                        setTimeout(function () {
                                            cargarTablaAseguradora();
                                        }, 1000);
                                    }else{
                                        log("Error al borrar la aseguradora", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarAseguradora;

        return items
    }
</script>

</body>
</html>
