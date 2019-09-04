<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/19
  Time: 9:18
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Programación</title>

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
        <a href="#" class="btn btn-primary btnCrear">
            <i class="fa fa-file"></i> Nueva Programación
        </a>
    </div>
</div>

%{--<div style="margin-top: 10px; min-height: 60px" class="vertical-container">--}%
%{--    <p class="css-vertical-text"></p>--}%

%{--    <div class="linea"></div>--}%

%{--    <div>--}%
%{--        <div class="col-md-12">--}%
%{--            Buscar Zona--}%
%{--            <div class="btn-group">--}%
%{--                <input id="buscar" type="search" class="form-control">--}%
%{--            </div>--}%
%{--            <a href="#" name="busqueda" class="btn btn-success btnBusqueda btn-ajax"><i--}%
%{--                    class="fas fa-search"></i> Buscar</a>--}%
%{--            <a href="#" name="lB" class="limpiaBuscar btn btn-info"><i class="fa fa-eraser"></i> Limpiar</a>--}%

%{--        </div>--}%
%{--    </div>--}%
%{--</div>--}%

<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Programación</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 70%">Descripción</th>
            <th class="alinear" style="width: 15%">Fecha Inicio</th>
            <th class="alinear" style="width: 15%">Fecha Fin</th>
        </tr>
        </thead>
    </table>

    <div id="tablaProgramacion">
    </div>
</div>


<script type="text/javascript">

    $(".btnCrear").click(function () {
       createEditProgramacion(null);
    });

    cargarTablaProgramacion();

    function cargarTablaProgramacion (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'programacion', action: 'tablaProgramacion')}',
            data:{

            },
            success: function (msg) {
                $("#tablaProgramacion").html(msg)
            }
        });
    }

    // $("input").keyup(function (ev) {
    //     if (ev.keyCode == 13) {
    //         $(".btnBusqueda").click();
    //     }
    // });

    function createEditProgramacion(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'programacion', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditP",
                    title : title + " Programación",
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
                                return submitFormP();
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


    function submitFormP() {
        var $form = $("#frmSave-programacionInstance");
        var $btn = $("#dlgCreateEditP").find("#btnSave");
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
                            // location.reload(true);
                            cargarTablaProgramacion();
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
            label: 'Editar Programación',
            icon: "fa fa-pen text-info",
            action : function () {
                createEditProgramacion(id);
            }
        };

        var borrarProgramacion = {
            label            : "Borrar programacion",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Programación",
                    message: "Está seguro de borrar esta programación? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'programacion', action: 'borrarProgramacion_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Programación borrada correctamente","success");
                                        setTimeout(function () {
                                            // location.reload(true);
                                            cargarTablaProgramacion();
                                        }, 1000);
                                    }else{
                                        log("Error al borrar la programación", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarProgramacion;

        return items
    }
</script>

</body>
</html>
