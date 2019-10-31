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
    <title>Unidades de Medida</title>

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
            <i class="fa fa-file"></i> Nuevo Unidad
        </a>

    </div>
</div>


<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Unidad de Medida</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 35%">Código</th>
            <th class="alinear" style="width: 65%">Descripción</th>
        </tr>
        </thead>
    </table>

    <div id="tablaUnidad">
    </div>
</div>


<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditUnidad(null)
    });

    cargarTablaUnidad();

    function cargarTablaUnidad (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'unidad', action: 'tablaUnidad')}',
            data:{

            },
            success: function (msg) {
                $("#tablaUnidad").html(msg)
            }
        });
    }

    function createEditUnidad(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'unidad', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditUnidad",
                    title : title + " Unidad",
                    // class : "modal-lg",
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
                                return submitFormUnidad();
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


    function submitFormUnidad() {
        var $form = $("#frmSaveUnidad");
        var $btn = $("#dlgCreateEditUnidad").find("#btnSave");
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
                            cargarTablaUnidad()
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
            label: 'Editar Unidad',
            icon: "fa fa-pen text-info",
            action : function () {
                createEditUnidad(id);
            }
        };

        var borrarUnidad = {
            label            : "Borrar Unidad",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Unidad",
                    message: "Está seguro de borrar esta unidad? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'unidad', action: 'borrarUnidad_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Unidad borrada correctamente","success");
                                        setTimeout(function () {
                                            cargarTablaUnidad();
                                        }, 1000);
                                    }else{
                                        log("Error al borrar la Unidad", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarUnidad

        return items
    }
</script>

</body>
</html>
