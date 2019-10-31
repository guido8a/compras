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
    <title>Lista de Años</title>

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
            <i class="fa fa-file"></i> Nuevo Año
        </a>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Lista de Años</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 100%">Año</th>
        </tr>
        </thead>
    </table>

    <div id="tablaAnio">
    </div>
</div>

<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditAnio(null)
    });

    cargarAnio();

    function cargarAnio(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'anio', action: 'tablaAnio')}',
            data:{

            },
            success: function (msg) {
                $("#tablaAnio").html(msg)
            }
        });
    }

    function createEditAnio(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'anio', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditAnio",
                    title : title + " Año",
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
                                return submitFormAnio();
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


    function submitFormAnio() {
        var $form = $("#frmSaveAnio");
        var $btn = $("#dlgCreateEditAnio").find("#btnSave");
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
                    // var parts = msg.split("_");
                    if(msg == 'no'){
                        log("Año guardado correctamente", "success");
                        setTimeout(function () {
                            cargarAnio()
                        }, 1000);
                    }else{
                        if(msg == 'ok'){
                            log("Error al guardar el año", "error");
                        }else{
                            var parts = msg.split("_");
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }
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
                createEditAnio(id);
            }
        };

        var borrarAnio = {
            label            : "Borrar",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Año",
                    message: "Está seguro de borrar este Año? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'anio', action: 'borrarAnio_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    var parts = msg.split("_");
                                    if(parts[0] == 'ok'){
                                        log("Año borrado correctamente","success");
                                        setTimeout(function () {
                                            cargarAnio();
                                        }, 1000);
                                    }else{
                                        if(parts[0] == 'er'){
                                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                            return false;
                                        }else{
                                           log("Error al borrar el año", "error")
                                        }

                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        // items.editar = editar;
        items.borrar = borrarAnio;

        return items
    }
</script>

</body>
</html>
