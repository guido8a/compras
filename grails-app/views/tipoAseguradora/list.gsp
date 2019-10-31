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
    <title>Tipo de Aseguradora</title>

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

<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Tipo de Aseguradora</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 35%">Código</th>
            <th class="alinear" style="width: 65%">Descripción</th>
        </tr>
        </thead>
    </table>

    <div id="tablaTipoAseguradora">
    </div>
</div>


<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditTipoAseguradora(null)
    });

    cargarTablaTipoAseguradora();

    function cargarTablaTipoAseguradora (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'tipoAseguradora', action: 'tablaTipoAseguradora')}',
            data:{
            },
            success: function (msg) {
                $("#tablaTipoAseguradora").html(msg)
            }
        });
    }

    function createEditTipoAseguradora(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'tipoAseguradora', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditTipoAseguradora",
                    title : title + " Tipo de Aseguradora",
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
                                return submitFormTipoAseguradora();
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

    function submitFormTipoAseguradora() {
        var $form = $("#frmSaveTipoAseguradora");
        var $btn = $("#dlgCreateEditTipoAseguradora").find("#btnSave");
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
                            cargarTablaTipoAseguradora()
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
                createEditTipoAseguradora(id);
            }
        };

        var borrarTipoAseguradora= {
            label            : "Borrar",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Tipo de Aseguradora",
                    message: "Está seguro de borrar este Tipo de Aseguradora? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'tipoAseguradora', action: 'borrarTipoAseguradora_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Tipo de Aseguradora borrada correctamente","success");
                                        setTimeout(function () {
                                            cargarTablaTipoAseguradora();
                                        }, 1000);
                                    }else{
                                        log("Error al borrar el tipo de aseguradora", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarTipoAseguradora;

        return items
    }
</script>

</body>
</html>
