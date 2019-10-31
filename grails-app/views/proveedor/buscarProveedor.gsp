<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/19
  Time: 14:41
--%>

<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Proveedores</title>

    <style type="text/css">

    .alinear {
        text-align : center !important;
    }

    #buscar {
        width: 400px;
        border-color: #37ad7d;
    }
    #limpiaBuscar {
        position: absolute;
        right: 5px;
        top: 0;
        bottom: 0;
        height: 14px;
        margin: auto;
        font-size: 14px;
        cursor: pointer;
        color: #ccc;
    }
    </style>

</head>

<body>
<div style="min-height: 60px" class="vertical-container">
    <p class="css-vertical-text"></p>

    <div class="linea"></div>

    <div>
        <div class="col-md-12">

            <div class="btn-group">
                <label>Cantón</label>
                <g:select name='canton' from="${compras.Canton.list().sort{it.provincia.nombre}}" optionKey="id" optionValue="${{it.provincia.nombre +' - '+it.nombre}}" noSelection="${['' : 'Todos los cantones']}" class="form-control"/>
            </div>
            <div class="btn-group">
                <label>Ruc</label>
                <g:textField name="ruc" type="search" class="form-control ru"/>
            </div>
            <div class="btn-group">
                <label>Nombre</label>
                <g:textField name="nombre"  type="search" class="form-control nm"/>
            </div>
            <div class="btn-group" style="margin-top: 17px">
                <a href="#" name="busqueda" class="btn btn-success btnBusqueda btn-ajax" title="Buscar proveedor"><i class="fa fa-search"></i> Buscar</a>
                <a href="#" name="lb" class="limpiaBuscar btn btn-warning" title="Limpiar campos de búsqueda"><i class="fa fa-eraser"></i> Limpiar</a>
                <a href="#" name="cp" class="btnCrearPro btn btn-info" title="Nuevo proveedor"><i class="fa fa-file"></i> Nuevo</a>
            </div>

        </div>
    </div>
</div>

<div style="margin-top: 30px; min-height: 660px" class="vertical-container">
    <p class="css-vertical-text">Resultado - Proveedores</p>
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear"  style="width: 25%">Nombre</th>
            <th class="alinear"  style="width: 10%">RUC</th>
            <th class="alinear"  style="width: 10%">Tipo</th>
            <th class="alinear" style="width: 10%">Teléfono</th>
            <th class="alinear" style="width: 22%">Contacto</th>
            <th class="alinear" style="width: 15%">Cantón</th>
            <th class="alinear" style="width: 8%">Estado</th>
        </tr>
        </thead>
    </table>

    <div id="tablaProveedores">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna como máximo 20 <span class="text-info" style="margin-left: 40px">Se ordena por nombre del proveedor</span>
</div>

<script type="text/javascript">

    $(".limpiaBuscar").click(function () {
        $(".nm").val('');
        $(".ru").val('');
        cargarBandeja();
    });

    cargarBandeja();

    $(".btnCrearPro").click(function () {
        createEditTipoProveedor(null)
    });

    function createEditTipoProveedor(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'proveedor', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditProveedor",
                    title : title + " Proveedor",
                    class : "modal-lg",
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
                                return submitFormProveedor();
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

    function submitFormProveedor() {
        var $form = $("#frmSaveProveedor");
        var $btn = $("#dlgCreateEditProveedor").find("#btnSave");

        if($("#cantonId option:selected").val() != 'null'){
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
                                cargarBandeja()
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
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Seleccione un cantón!" + '</strong>');
            return false;
        }
    }

    function cargarBandeja(){
        $("#bandeja").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        var canton = $("#canton").val();
        var nombre = $("#nombre").val();
        var ruc = $("#ruc").val();
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'proveedor', action: 'tablaProveedor')}",
            data    : {
                canton: canton,
                nombre: nombre,
                ruc: ruc
            },
            success : function (msg) {
                dialog.modal('hide');
                $("#tablaProveedores").html(msg);
            },
            error   : function (msg) {
                dialog.modal('hide');
                $("#tablaProveedores").html("Ha ocurrido un error");
            }
        });
    }

    $(".btnBusqueda").click(function () {
        cargarBandeja();
    });

    $("input").keyup(function (ev) {
        if (ev.keyCode == 13) {
            $(".btnBusqueda").click();
        }
    });


   function submitForm() {
        var $form = $("#frmActividad");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'actividad', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        cargarBandeja();
                    } else {
                        cargarBandeja();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function createContextMenu(node) {
        var $tr = $(node);
        var data = id ? { id: id } : {};

        var items = {
            header : {
                label  : "Acciones",
                header : true
            }
        };

        var id = $tr.data("id");

        var ver = {
            label  : 'Ver',
            icon   : "fa fa-search",
            action : function (e) {
                $("#dialog-body").html(spinner);
                $.ajax({
                    type    : 'POST',
                    url     : '${createLink(controller: 'actividad', action: 'show_ajax')}',
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        $("#dialog-body").html(msg)
                    }
                });
                $("#dialog").modal("show");
            }
        };

        var editar = {
            label: 'Editar',
            icon: "fa fa-pen text-info",
            action : function () {
                createEditTipoProveedor(id);
            }
        };
        var borrarProveedor = {
            label            : "Borrar",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Proveedor",
                    message: "Está seguro de borrar el proveedor? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'proveedor', action: 'borrarProveedor_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Proveedor borrado correctamente","success");
                                        setTimeout(function () {
                                            cargarBandeja()
                                        }, 1000);
                                    }else{
                                        log("Error al borrar el proveedor", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };


        items.ver = ver;
        items.editar = editar;
        items.borrar = borrarProveedor
        return items
    }

    $(".limpiaBuscar").click(function () {
        $("#buscar").val("");
    });


</script>

</body>
</html>