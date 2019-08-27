<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Zonas</title>

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
        <g:link action="form" class="btn btn-primary btnCrear">
            <i class="fa fa-file"></i> Nueva Zona
        </g:link>
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
    <p class="css-vertical-text">Zonas</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 15%">Número</th>
            <th class="alinear" style="width: 35%">Nombre</th>
            <th class="alinear" style="width: 25%">Latitud</th>
            <th class="alinear" style="width: 25%">Longitud</th>
        </tr>
        </thead>
    </table>

    <div id="tablaZona">
    </div>
</div>


<script type="text/javascript">

    cargarZona();

    //
    // $("#btnBusqueda").click(function () {
    //     cargarZona();
    // });

    function cargarZona (){
        $.ajax({
           type: 'POST',
           url: '${createLink(controller: 'zona', action: 'tablaZona')}',
           data:{

           },
           success: function (msg) {
            $("#tablaZona").html(msg)
           }
        });
    }


    var id = null;
    function submitForm() {
        var $form = $("#frmZona");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'zona', action:'save_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    if (msg == "OK") {
                        log("Zona guardada correctamente!", "success");
                        cargarZona()
                    } else {
                        log("Error al guardar la zona","error")
                        return false
                    }
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteRow(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Actividad seleccionado? Esta acción no se puede deshacer.</p>",
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash-o'></i> Eliminar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(action:'delete_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 500);
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function iniciarActv(itemId) {
        bootbox.dialog({
            title: "Iniciar actividad",
            message: "<i class='fa fa-gears fa-3x pull-left text-info text-shadow'></i>" +
              "<p>¿Está seguro que desea iniciar la Actividad seleccionada? Esta acción no se puede deshacer.</p>",
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-gears'></i> Iniciar",
                    className: "btn-info",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(action:'iniciar_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 500);
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function finalizarActv(itemId) {
        bootbox.dialog({
            title: "Finalizar actividad",
            message: "<i class='fa fa-check fa-3x pull-left text-info text-shadow'></i>" +
              "<p>¿Está seguro que desea poner como finalizada la Actividad seleccionada? Esta acción no se puede deshacer.</p>",
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-check'></i> Finalizar",
                    className: "btn-info",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(action:'finalizar_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 500);
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id: id} : {};
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'zona',  action:'form_ajax')}",
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCreateEdit",
                    class: "large",
                    title: title + " Zona",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                return submitForm();
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

    %{--$(function () {--}%

        $(".btnCrear").click(function () {
            createEditRow();
            return false;
        });

    %{--    $("tbody tr").contextMenu({--}%
    %{--        items: {--}%
    %{--            header: {--}%
    %{--                label: "Acciones",--}%
    %{--                header: true--}%
    %{--            },--}%
    %{--            ver: {--}%
    %{--                label: "Ver",--}%
    %{--                icon: "fa fa-search",--}%
    %{--                action: function ($element) {--}%
    %{--                    var id = $element.data("id");--}%
    %{--                    $.ajax({--}%
    %{--                        type: "POST",--}%
    %{--                        url: "${createLink(action:'show_ajax')}",--}%
    %{--                        data: {--}%
    %{--                            id: id--}%
    %{--                        },--}%
    %{--                        success: function (msg) {--}%
    %{--                            bootbox.dialog({--}%
    %{--                                title: "Ver",--}%
    %{--                                message: msg,--}%
    %{--                                buttons: {--}%
    %{--                                    ok: {--}%
    %{--                                        label: "Aceptar",--}%
    %{--                                        className: "btn-primary",--}%
    %{--                                        callback: function () {--}%
    %{--                                        }--}%
    %{--                                    }--}%
    %{--                                }--}%
    %{--                            });--}%
    %{--                        }--}%
    %{--                    });--}%
    %{--                }--}%
    %{--            },--}%
    %{--            editar: {--}%
    %{--                label: "Editar",--}%
    %{--                icon: "fa fa-pencil",--}%
    %{--                action: function ($element) {--}%
    %{--                    var id = $element.data("id");--}%
    %{--                    createEditRow(id);--}%
    %{--                }--}%
    %{--            },--}%
    %{--            iniciar: {--}%
    %{--                label: "Iniciar",--}%
    %{--                icon: "fa fa-gears",--}%
    %{--                separator_before: true,--}%
    %{--                action: function ($element) {--}%
    %{--                    var id = $element.data("id");--}%
    %{--                    iniciarActv(id);--}%
    %{--                }--}%
    %{--            },--}%
    %{--            finalizar: {--}%
    %{--                label: "Finalizar",--}%
    %{--                icon: "fa fa-check",--}%
    %{--                separator_before: true,--}%
    %{--                action: function ($element) {--}%
    %{--                    var id = $element.data("id");--}%
    %{--                    finalizarActv(id);--}%
    %{--                }--}%
    %{--            },--}%
    %{--            eliminar: {--}%
    %{--                label: "Eliminar",--}%
    %{--                icon: "fa fa-trash-o",--}%
    %{--                separator_before: true,--}%
    %{--                action: function ($element) {--}%
    %{--                    var id = $element.data("id");--}%
    %{--                    deleteRow(id);--}%
    %{--                }--}%
    %{--            }--}%
    %{--        },--}%
    %{--        onShow: function ($element) {--}%
    %{--            $element.addClass("trHighlight");--}%
    %{--        },--}%
    %{--        onHide: function ($element) {--}%
    %{--            $(".trHighlight").removeClass("trHighlight");--}%
    %{--        }--}%
    %{--    });--}%

    %{--});--}%


    $("input").keyup(function (ev) {
        if (ev.keyCode == 13) {
            $(".btnBusqueda").click();
        }
    });

    function createContextMenu(node) {
        var $tr = $(node);
        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var id = $tr.data("id");

        var ver = {
            label: 'Ver Documentos',
            icon: "fa fa-search",
            action: function (e) {
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'base', action: 'tablaArchivos')}',
                    data:{
                        id: id,
                        band: 1
                    },
                    success: function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgVerDocs",
                            title   : "Ver documentos",
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            } //buttons
                        }); //dialog
                        // $("#dialog-body").html(msg)
                    }
                });
                // $("#dialog").modal("show");
            }
        };

        items.ver = ver;

        return items
    }
</script>

</body>
</html>
