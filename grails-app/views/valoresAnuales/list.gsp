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
    <title>valores Auales</title>

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
            <i class="fa fa-file"></i> Nuevo Valor
        </a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-warning btnCrearAnio">
            <i class="fab fa-amilia"></i> Crear Año
        </a>
    </div>
 </div>

<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Valores Anuales</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%;background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear" style="width: 20%">Año</th>
            <th class="alinear" style="width: 10%">Sueldo Básico Unificado</th>
            <th class="alinear" style="width: 10%">Seguro</th>
            <th class="alinear" style="width: 10%">Tasa de Interés Anual</th>
            <th class="alinear" style="width: 10%">Factor Costo Repuestos</th>
            <th class="alinear" style="width: 10%">Inflación</th>
            <th class="alinear" style="width: 10%">Costo Diesel</th>
            <th class="alinear" style="width: 10%">Costo Grasa</th>
            <th class="alinear" style="width: 10%">Costo Lubricante</th>
        </tr>
        </thead>
    </table>

    <div id="tablaValores">
    </div>
</div>

<script type="text/javascript">

    $(".btnCrear").click(function () {
        createEditValores(null)
    });

    $(".btnCrearAnio").click(function () {
        createEditAnio(null)
    });


    cargarTablaValores();

    function cargarTablaValores(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'valoresAnuales', action: 'tablaValoresAnuales')}',
            data:{
            },
            success: function (msg) {
                $("#tablaValores").html(msg)
            }
        });
    }

    function createEditValores(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'valoresAnuales', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditValores",
                    title : title + " Valores Anuales",
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
                                return submitFormValores();
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

    function submitFormValores() {
        var $form = $("#frmSaveValores");
        var $btn = $("#dlgCreateEditValores").find("#btnSave");
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
                            cargarTablaValores()
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
                createEditValores(id);
            }
        };

        var borrarValor = {
            label            : "Borrar",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Valores Anuales",
                    message: "Está seguro de borrar los valores anuales? Esta acción no puede deshacerse.",
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
                                url: '${createLink(controller: 'valoresAnuales', action: 'borrarValores_ajax')}',
                                data:{
                                    id: id
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Valores anuales borrados correctamente","success");
                                        setTimeout(function () {
                                            cargarTablaValores()
                                        }, 1000);
                                    }else{
                                        log("Error al borrar los valores anuales", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        items.editar = editar;
        items.borrar = borrarValor;

        return items
    }
</script>

</body>
</html>
