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
    <title>Tipo de Adquisición</title>

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
            <i class="fa fa-file"></i> Nuevo Tipo
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
    <p class="css-vertical-text">Tipo de Adquisición</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 35%">Código</th>
            <th class="alinear" style="width: 65%">Descripción</th>
        </tr>
        </thead>
    </table>

    <div id="tablaAdquisición">
    </div>
</div>


<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditTipoAdquisicion(null)
    });

    cargarTablaAdquisicion();

    function cargarTablaAdquisicion (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'tipoAdquisicion', action: 'tablaAdquisicion')}',
            data:{

            },
            success: function (msg) {
                $("#tablaAdquisición").html(msg)
            }
        });
    }

    // $("input").keyup(function (ev) {
    //     if (ev.keyCode == 13) {
    //         $(".btnBusqueda").click();
    //     }
    // });

    function createEditTipoAdquisicion(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'tipoAdquisicion', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditTA",
                    title : title + " Tipo de Adquisición",
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
                                return submitFormTA();
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


    function submitFormTA() {
        var $form = $("#frmSave-tipoAdquisicionInstance");
        var $btn = $("#dlgCreateEditTA").find("#btnSave");
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
                            cargarTablaAdquisicion()
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
            label: 'Editar Tipo',
            icon: "fa fa-pen text-info",
            action : function () {
                createEditTipoAdquisicion(id);
            }
        };

        var borrarTipoAdquisicion = {
            label            : "Borrar Tipo Adquisición",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Tipo Adquisición",
                    message: "Está seguro de borrar este tipo de adquisición? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'tipoAdquisicion', action: 'borrarTipoAdquisicion_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Tipo de Adquisición borrada correctamente","success");
                                        setTimeout(function () {
                                            // location.reload(true);
                                            cargarTablaAdquisicion()
                                        }, 1000);
                                    }else{
                                        log("Error al borrar el tipo de adquisición", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarTipoAdquisicion

        return items
    }
</script>

</body>
</html>
