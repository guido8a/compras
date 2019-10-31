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
    <title>Funciones del Personal</title>

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
            <i class="fa fa-file"></i> Nueva Función
        </a>

    </div>
</div>

<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Funciones del personal</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 35%">Código</th>
            <th class="alinear" style="width: 65%">Descripción</th>
        </tr>
        </thead>
    </table>

    <div id="tablaFuncion">
    </div>
</div>


<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditFuncion(null)
    });

    cargarTablaFuncion();

    function cargarTablaFuncion (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'funcion', action: 'tablaFuncion')}',
            data:{

            },
            success: function (msg) {
                $("#tablaFuncion").html(msg)
            }
        });
    }

    function createEditFuncion(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'funcion', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditFuncion",
                    title : title + " Función",
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
                                return submitFormFuncion();
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


    function submitFormFuncion() {
        var $form = $("#frmSaveFuncion");
        var $btn = $("#dlgCreateEditFuncion").find("#btnSave");
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
                            cargarTablaFuncion()
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
            label: 'Editar Función',
            icon: "fa fa-pen text-info",
            action : function () {
                createEditFuncion(id);
            }
        };

        var borrarFuncion = {
            label            : "Borrar Función",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Función",
                    message: "Está seguro de borrar esta función? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'funcion', action: 'borrarFuncion_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Función borrada correctamente","success");
                                        setTimeout(function () {
                                            cargarTablaFuncion();
                                        }, 1000);
                                    }else{
                                        log("Error al borrar la Función", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarFuncion;

        return items
    }
</script>

</body>
</html>
