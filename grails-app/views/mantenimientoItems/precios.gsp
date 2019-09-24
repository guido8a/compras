<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>PRECIOS Y MANT. DE ITEMS</title>

    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree', file: 'jquery.jstree.js')}"></script>--}%
    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree/_lib', file: 'jquery.cookie.js')}"></script>--}%

    %{--        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>--}%
    %{--        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>--}%

    %{--        <script src="${resource(dir: 'js/jquery/plugins/jgrowl', file: 'jquery.jgrowl.js')}"></script>--}%
    %{--        <link href="${resource(dir: 'js/jquery/plugins/jgrowl', file: 'jquery.jgrowl.css')}" rel="stylesheet"/>--}%
    %{--        <link href="${resource(dir: 'js/jquery/plugins/jgrowl', file: 'jquery.jgrowl.customThemes.css')}" rel="stylesheet"/>--}%

    %{--        <g:if test="${janus.Parametros.findByEmpresaLike(message(code: 'ambiente2'))}">--}%
    %{--            <link href="${resource(dir: 'css', file: 'treeV2.css')}" rel="stylesheet"/>--}%
    %{--        </g:if>--}%
    %{--        <g:else>--}%
    %{--            <link href="${resource(dir: 'css', file: 'tree.css')}" rel="stylesheet"/>--}%
    %{--        </g:else>--}%


    %{--        <script type="text/javascript" src="${resource(dir: 'js', file: 'tableHandlerBody.js')}"></script>--}%
    %{--        <link href="${resource(dir: 'css', file: 'tableHandler.css')}" rel="stylesheet"/>--}%


    <asset:javascript src="/jstree/jquery.jstree.js"/>
    <asset:javascript src="/jstree/_lib/jquery.cookie.js"/>
    <asset:javascript src="/jstree/_lib/jquery.hotkeys.js"/>
    <asset:javascript src="/apli/tableHandlerBody.js"/>
    <asset:stylesheet src="/apli/treeV2.css"/>
    <asset:stylesheet src="/apli/tableHandler.css"/>


    <style type="text/css">

    li.jstree-open > a .jstree-icon {background:url('<asset:image src="/tree/edit.png"/>') 0px 0px no-repeat !important;}
    /*li.jstree-open > a .jstree-icon {"icon":"fa fa-user fa-2x"  0px 0px no-repeat !important;}*/
    li.jstree-closed > a .jstree-icon {background:url('<asset:image src="/tree/edit.png"/>') 0px 0px no-repeat !important;}
    li.jstree-leaf > a .jstree-icon { display: none; }

    </style>

</head>

<body>

<div class="span12">
    <g:if test="${flash.message}">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            ${flash.message}
        </div>
    </g:if>
</div>

<div class="col-md-3 btn-group" data-toggle="buttons-radio">
    <a href="#" id="1" class="btn btn-success toggle active" data-reporte="materiales">
        <i class="fa fa-box-open"></i>
        Bienes <!--grpo--><!--sbgr -> Grupo--><!--dprt -> Subgrupo--><!--item-->
    </a>
    <a href="#" id="2" class="btn btn-warning toggle" data-reporte="mano_obra">
        <i class="fa fa-users-cog"></i>
        Servicios
    </a>
    %{--    <a href="#" id="3" class="btn btn-info toggle" data-reporte="equipos">--}%
    %{--        <i class="icon-truck"></i>--}%
    %{--        Equipos--}%
    %{--    </a>--}%
</div>

%{--<div class="col-md-4">--}%
%{--    <div class="col-md-3">--}%
%{--        <label>Fecha por Defecto:</label>--}%
%{--    </div>--}%
%{--    <div class="col-md-5">--}%
%{--        <input name="fecha" id='fcDefecto' type='text' class="datetimepicker1 form-control" value="${new Date().format("dd-MM-yyyy")}"/>--}%
%{--    </div>--}%
%{--</div>--}%

<div class="col-md-5">
    <form class="form-search">
        <input type="text" class="input-medium search-query" id="search"/>
        <a href='#' class='btn btn-success' id="btnSearch"><i class='icon-zoom-in'></i> Buscar</a>
        <span id="cantRes"></span>
    </form>
</div>

<div id="loading" style="text-align:center;">
    %{--    <img src="${resource(dir: 'images', file: 'spinner_24.gif')}" alt="Cargando..."/>--}%
    <p>Cargando... Por favor espere.</p>
</div>

<div id="treeArea" style="float: left;margin-top: 15px;">
    <div class="btn-toolbar" style="margin-top: -20px;">


        <a href="#" id="btnCerrarArbol" class="btn btn-info btn-ajax" onclick="$('#tree').jstree('close_all');"><i class="fa fa-minus-circle"></i> Cerrar arbol</a>
        <a href="#" id="btnRefresh" class="btn btn-info btn-ajax"><i class="fa fa-sync"></i> Refrescar</a>


        <div class="btn-group" data-toggle="buttons-checkbox">
            <a href="#" id="ignore" class="btn btn-primary toggleTipo">
                <i class="fa fa-globe"></i> Listar todos los lugares
            </a>
        </div>

        %{--        <div class="btn-group">--}%
        %{--            <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#">--}%
        %{--                <span id="spFecha">--}%
        %{--                    Todas las fechas--}%
        %{--                </span>--}%
        %{--                <span class="caret"></span>--}%
        %{--            </a>--}%
        %{--            <ul class="dropdown-menu">--}%
        %{--                <li>--}%
        %{--                    <a href="#" class="fecha" data-operador="all" data-fecha='false'>--}%
        %{--                        Todas las fechas--}%
        %{--                    </a>--}%
        %{--                </li>--}%
        %{--                <li>--}%
        %{--                    <a href="#" class="fecha" data-operador="=" data-fecha='true'>--}%
        %{--                        Fecha igual--}%
        %{--                    </a>--}%
        %{--                </li>--}%
        %{--                <li>--}%
        %{--                    <a href="#" class="fecha" data-operador="<=" data-fecha='true'>--}%
        %{--                        Hasta la fecha--}%
        %{--                    </a>--}%
        %{--                </li>--}%
        %{--            </ul>--}%
        %{--        </div>--}%

        <span class="hide" id="divFecha">
            %{--            <elm:datepicker name="fecha" class="input-small" onClose="cambiaFecha" yearRange="${(new Date().format('yyyy').toInteger() - 40).toString() + ':' + new Date().format('yyyy')}"/>--}%

            <input name="fecha" id='fecha' type='text' class="datetimepicker2 form-control" value="${new Date().format("dd-MM-yyyy")}"/>
        </span>

        <div class="btn-group">
        </div>

        <div class="btn-group">
            <g:link action="registro" class="btn btn-primary">
                <i class="fa fa-list"></i> Ir a Items
            </g:link>
        </div>

        %{--        <div class="btn-group">--}%
        %{--            <a href="#" id="btnReporte" class="btn btn-primary btn-ajax">--}%
        %{--                <i class="fa fa-print"></i> Reporte--}%
        %{--            </a>--}%
        %{--        </div>--}%
        %{--            <g:if test="${session.perfil.codigo == 'CSTO'}">--}%
        %{--                <g:link controller="item" action="mantenimientoPrecios" class="btn btn-primary">--}%
        %{--                    <i class="icon-money"></i> Mantenimiento de precios--}%
        %{--                </g:link>--}%
        %{--                <g:link controller="item" action="precioVolumen" class="btn btn-primary">--}%
        %{--                    <i class="icon-money"></i> Precios por Volumen--}%
        %{--                </g:link>--}%
        %{--                <g:link controller="item" action="registrarPrecios" class="btn btn-primary">--}%
        %{--                    <i class="icon-ok"></i> Registrar--}%
        %{--                </g:link>--}%
        %{--            </g:if>--}%


    </div>

    <div id="tree" class="ui-corner-all"></div>

    <div id="info" class="ui-corner-all"></div>
</div>

<div class="modal hide fade" id="modal-tree">
    <div class="modal-header" id="modalHeader">
        <button type="button" class="close simplemodal-close" data-dismiss="modal">×</button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody">

    </div>

    <div class="modal-footer" id="modalFooter">
    </div>
</div>

<script type="text/javascript">

    // $('.datetimepicker1').datetimepicker({
    //     locale: 'es',
    //     format: 'DD-MM-YYYY',
    //     daysOfWeekDisabled: [0, 6],
    //     // inline: true,
    //     // sideBySide: true,
    //     showClose: true,
    //     icons: {
    //         close: 'closeText'
    //     }
    // });

    $('.datetimepicker2').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        // inline: true,
        // sideBySide: true,
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });


    // $.jGrowl.defaults.closerTemplate = '<div>[ cerrar todo ]</div>';

    var btn = $("<a href='#' class='btn btn-success' id='btnSearch'><i class='icon-zoom-in'></i> Buscar</a>");
    var urlSp = "${resource(dir: 'images', file: 'spinner.gif')}";
    var sp = $('<span class="add-on" id="btnSearch"><img src="' + urlSp + '"/></span>');

    var current = "1";
    var showLugar = {
        all      : false,
        ignore   : false,
        fecha    : "all",
        operador : ""
    };

    var icons = {
        edit                     : '<asset:image src="/tree/edit.png"/>',
        delete                   : '<asset:image src="/tree/delete.gif"/>',
        info                     : '<asset:image src="/tree/info.png"/>',
        copiar                   : '<asset:image src="/tree/copiar.png"/>',

        grupo_material           : '<asset:image src="/tree/carpeta2.png"/>',
        grupo_manoObra           : '<asset:image src="/tree/carpeta5.png"/>',
        grupo_equipo             : '<asset:image src="/tree/carpeta6.png"/>',
        grupo_consultoria        : '<asset:image src="/tree/carpeta5.png"/>',

        subgrupo_material        : '<asset:image src="tree/carpeta.png"/>',
        subgrupo_manoObra        : '<asset:image src="/tree/subgrupo_manoObra.png"/>',
        subgrupo_equipo          : '<asset:image src="/tree/item_equipo.png"/>',
        subgrupo_consultoria     : '<asset:image src="/tree/subgrupo_manoObra.png"/>',

        departamento_material    : '<asset:image src="/tree/carpeta3.png"/>',
        departamento_manoObra    : '<asset:image src="/tree/departamento_manoObra.png"/>',
        departamento_equipo      : '<asset:image src="/tree/departamento_equipo.png"/>',
        departamento_consultoria : '<asset:image src="/tree/departamento_manoObra.png"/>',

        item_material            : '<asset:image src="/tree/item_material.png"/>',
        item_manoObra            : '<asset:image src="/tree/item_manoObra.png"/>',
        item_equipo              : '<asset:image src="/tree/item_equipo.png"/>',
        item_consultoria         : '<asset:image src="/tree/item_material.png"/>',

        %{--lugar     : "${resource(dir: 'images/tree', file: 'lugar_c.png')}",--}%
        %{--lugar_c   : "${resource(dir: 'images/tree', file: 'lugar_c.png')}",--}%
        %{--lugar_v   : "${resource(dir: 'images/tree', file: 'lugar_v.png')}",--}%
        %{--lugar_all : "${resource(dir: 'images/tree', file: 'lugar_all.png')}"--}%
    };

    function cambiaFecha(dateText, inst) {
        showLugar.fecha = dateText;
    }

    function createContextmenu(node) {
        var parent = node.parent().parent();

        var nodeStrId = node.attr("id");
        var nodeText = $.trim(node.children("a").text());

        var parentStrId = parent.attr("id");
        var parentText = $.trim(parent.children("a").text());

        var nodeRel = node.attr("rel");
        var parts = nodeRel.split("_");
        var nodeNivel = parts[0];
        var nodeTipo = parts[1];

        var parentRel = parent.attr("rel");
        parts = nodeRel.split("_");
        var parentNivel = parts[0];
        var parentTipo = parts[1];

        parts = nodeStrId.split("_");
        var nodeId = parts[1];
        if (parts.length == 3) {
            nodeId = parts[2];
        }

        parts = parentStrId.split("_");
        var parentId = parts[1];

        var nodeHasChildren = node.hasClass("hasChildren");
        var cantChildren = node.children("ul").children().size();
        nodeHasChildren = nodeHasChildren || cantChildren != 0;

        var menuItems = {}, lbl = "", item = "";

        switch (nodeTipo) {
            case "material":
                lbl = "o material";
                item = "Material";
                break;
            case "manoObra":
                lbl = "a mano de obra";
                item = "Mano de obra";
                break;
            case "equipo":
                lbl = "o equipo";
                item = "Equipo";
                break;
            case "C":
                break;
            case "V":
                break;
        }

        switch (nodeNivel) {
            case "item":
                if (!showLugar.ignore) {
                    %{--menuItems.crearHijo = createUpdate({--}%
                    %{--    action    : "create",--}%
                    %{--    label     : "Nueva lista",--}%
                    %{--    sepBefore : true,--}%
                    %{--    sepAfter  : false,--}%
                    %{--    icon      : icons.lugar_c,--}%
                    %{--    url       : "${createLink(action:'formLg_ajax')}",--}%
                    %{--    data      : {--}%
                    %{--        all : showLugar.all--}%
                    %{--    },--}%
                    %{--    open      : true,--}%
                    %{--    nodeStrId : nodeStrId,--}%
                    %{--    where     : "first",--}%
                    %{--    tipo      : "lg",--}%
                    %{--    log       : "Lista ",--}%
                    %{--    title     : "Nueva lista"--}%
                    %{--});--}%


                    menuItems.crearHijo = {
                        label  : "<i class='fa fa-star text-info'></i> Nueva Lista",
                        action : function () {
                            crearLista(null, nodeId)
                        }
                    }

                }
                break;
            case "lugar":
                if (!showLugar.ignore) {
                    %{--menuItems.editar = createUpdate({--}%
                    %{--    action    : "update",--}%
                    %{--    label     : "Editar lista",--}%
                    %{--    icon      : icons.edit,--}%
                    %{--    sepBefore : false,--}%
                    %{--    sepAfter  : false,--}%
                    %{--    url       : "${createLink(action:'formLge_ajax')}",--}%
                    %{--    data      : {--}%
                    %{--        id  : nodeId,--}%
                    %{--        all : showLugar.all--}%
                    %{--    },--}%
                    %{--    open      : false,--}%
                    %{--    nodeStrId : nodeStrId,--}%
                    %{--    log       : "Lista ",--}%
                    %{--    title     : "Editar lista"--}%
                    %{--});--}%

                    menuItems.editar = {
                        label  : "<i class='fa fa-pen text-success'></i> Editar Lista",
                        action : function () {
                            crearLista(nodeId, parentId)
                        }
                    };

                    menuItems.crearHermano = {
                        label  : "<i class='fa fa-star text-info'></i> Nueva Lista",
                        action : function () {
                            crearLista(null, parentId)
                        }
                    };

                    if (!nodeHasChildren) {
                        %{--menuItems.eliminar = remove({--}%
                        %{--    disabled     : node.data("obras") != 0,--}%
                        %{--    label        : "Eliminar lista",--}%
                        %{--    sepBefore    : false,--}%
                        %{--    sepAfter     : false,--}%
                        %{--    icon         : icons.delete,--}%
                        %{--    title        : "Eliminar lista",--}%
                        %{--    confirm      : "lista",--}%
                        %{--    extraConfirm : "? <br/><span style='font-weight: bold; font-size: larger'>Se eliminarán todos los precios de la lista y no se puede deshacer....</span>",--}%
                        %{--    url          : "${createLink(action:'deleteLg_ajax')}",--}%
                        %{--    data         : {--}%
                        %{--        id : nodeId--}%
                        %{--    },--}%
                        %{--    nodeStrId    : nodeStrId,--}%
                        %{--    parentStrId  : parentStrId,--}%
                        %{--    log          : "Lista "--}%
                        %{--});--}%

                        menuItems.eliminar = {
                            label            : "<i class='fa fa-trash text-danger'></i> Eliminar Lista",
                            separator_before : true,
                            action           : function () {
                                bootbox.confirm({
                                    title: "Eliminar lista",
                                    message: "Está seguro de borrar esta lista? Esta acción no puede deshacerse.",
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
                                                url: '${createLink(controller: 'mantenimientoItems', action: 'borrarListaPrecios_ajax')}',
                                                data:{
                                                    id: nodeId
                                                },
                                                success: function (msg) {
                                                    dialog.modal('hide');
                                                    var parts = msg.split("_")
                                                    if(parts[0] == 'ok'){
                                                        log(parts[1],"success");
                                                        setTimeout(function () {
                                                            location.reload(true);
                                                        }, 1000);
                                                    }else{
                                                        if(parts[0] == 'er'){
                                                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                                            return false;
                                                        }else{
                                                            log(parts[1], "error")
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    }
                                });
                            }
                        }


                    }
                    %{--menuItems.crearHermano = createUpdate({--}%
                    %{--    action    : "create",--}%
                    %{--    label     : "Nueva lista",--}%
                    %{--    icon      : icons.lugar_c,--}%
                    %{--    sepBefore : true,--}%
                    %{--    sepAfter  : true,--}%
                    %{--    url       : "${createLink(action:'formLg_ajax')}",--}%
                    %{--    data      : {--}%
                    %{--        all : showLugar.all--}%
                    %{--    },--}%
                    %{--    open      : false,--}%
                    %{--    nodeStrId : nodeStrId,--}%
                    %{--    where     : "after",--}%
                    %{--    tipo      : "lg",--}%
                    %{--    log       : "Lista ",--}%
                    %{--    title     : "Nueva lista"--}%
                    %{--});--}%



                }
                break;
        }

        return menuItems;
    }


    function crearLista(id, parentId){
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        if (parentId) {
            data.padre = parentId;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'mantenimientoItems', action:'formListaPrecios_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditListaPrecios",
                    title : title + " Lista de Precios",
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
                                return submitFormListaPrecios();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    }

    function submitFormListaPrecios () {
        var $form = $("#frmSaveListaPrecios");
        var $btn = $("#dlgCreateEditListaPrecios").find("#btnSave");
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
                            location.reload(true);
                        }, 1000);
                    }else{
                        if(parts[0] == 'er'){
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }else{
                            log(parts[1], "error")
                        }
                    }
                }
            });
        } else {
            return false;
        }
    }

    function initTree(tipo) {
        var id, rel, label;
        var li = "";
        switch (tipo) {
            case "1":
                id = "materiales_1";
                rel = "grupo_material";
                label = "Materiales";
                li = "<li id='" + id + "' class='root hasChildren jstree-closed' rel='" + rel + "' ><a href='#' class='label_arbol'>" + label + "</a></li>";
                break;
            case "2":

                $.ajax({
                    type    : "POST",
                    async   : false,
                    url     : "${createLink(action:'loadMO')}",
                    success : function (msg) {
                        var p = msg.split("*");
                        li = p[0];
                        id = p[1];
                    }
                });
                break;
            case "3":
                id = "equipos_3";
                rel = "grupo_equipo";
                label = "Equipos";
                li = "<li id='" + id + "' class='root hasChildren jstree-closed' rel='" + rel + "' ><a href='#' class='label_arbol'>" + label + "</a></li>";
                break;
        }
        $("#tree").bind("loaded.jstree",
            function (event, data) {
                $("#loading").hide();
                $("#treeArea").show();
            }).jstree({
            "core"        : {
                "initially_open" : [ id ]
            },
            "plugins"     : ["themes", "html_data", "json_data", "ui", "types", "contextmenu", "search", "cookies", "crrm"/*, "wholerow"*/],
            "html_data"   : {
                "data" : "<ul type='root'>" + li + "</ul>",
                "ajax" : {
                    "type"  : "POST",
                    "url"   : "${createLink(action: 'loadTreePart')}",
                    "data"  : function (n) {
                        var obj = $(n);
                        var id = obj.attr("id");
                        var parts = id.split("_");
                        id = 0;
                        if (parts.length > 1) {
                            id = parts[1]
                        }
                        var tipo = obj.attr("rel");
                        return {
                            id      : id,
                            tipo    : tipo,
                            precios : true,
                            all     : showLugar.all,
                            ignore  : showLugar.ignore
                        }
                    },
                    success : function (data) {
                    },
                    error   : function (data) {
                    }
                }
            },
            "types"       : {
                "valid_children" : [ "grupo_material", "grupo_manoObra", "grupo_equipo"  ],
                "types"          : {
                    "grupo_material" : {
                        "icon"           : {
                            // "image" : icons.grupo_material
                        },
                        "valid_children" : [ "subgrupo_material" ]
                    },
                    "grupo_manoObra" : {
                        "icon"           : {
                            // "image" : icons.grupo_manoObra
                        },
                        "valid_children" : [ "subgrupo_manoObra" ]
                    },
                    "grupo_equipo"   : {
                        "icon"           : {
                            "image" : icons.grupo_equipo
                        },
                        "valid_children" : [ "subgrupo_equipo" ]
                    },

                    "subgrupo_manoObra" : {
                        "icon"           : {
                            // "image" : icons.subgrupo_manoObra
                        },
                        "valid_children" : [ "departamento_manoObra" ]
                    },
                    "subgrupo_material" : {
                        "icon"           : {
                            // "image" : icons.subgrupo_material
                        },
                        "valid_children" : [ "departamento_material" ]
                    },
                    "subgrupo_equipo"   : {
                        "icon"           : {
                            "image" : icons.subgrupo_equipo
                        },
                        "valid_children" : [ "departamento_equipo" ]
                    },

                    "departamento_manoObra" : {
                        "icon"           : {
                            "image" : icons.departamento_manoObra
                        },
                        "valid_children" : [ "item_manoObra" ]
                    },
                    "departamento_material" : {
                        "icon"           : {
                            "image" : icons.departamento_material
                        },
                        "valid_children" : [ "item_material" ]
                    },
                    "departamento_equipo"   : {
                        "icon"           : {
                            "image" : icons.departamento_equipo
                        },
                        "valid_children" : [ "item_equipo" ]
                    },

                    "item_manoObra" : {
                        "icon"           : {
                            "image" : icons.item_manoObra
                        },
                        "valid_children" : [ "lugar_c", "lugar_v", "lugar_all" ]
                    },
                    "item_material" : {
                        "icon"           : {
                            "image" : icons.item_material
                        },
                        "valid_children" : [ "lugar_c", "lugar_v", "lugar_all" ]
                    },
                    "item_equipo"   : {
                        "icon"           : {
                            "image" : icons.item_equipo
                        },
                        "valid_children" : [ "lugar_c", "lugar_v", "lugar_all" ]
                    },

                    "lugar"     : {
                        "icon"           : {
                            "image" : icons.lugar
                        },
                        "valid_children" : [ "" ]
                    },
                    "lugar_c"   : {
                        "icon"           : {
                            "image" : icons.lugar_c
                        },
                        "valid_children" : [ "" ]
                    },
                    "lugar_v"   : {
                        "icon"           : {
                            "image" : icons.lugar_v
                        },
                        "valid_children" : [ "" ]
                    },
                    "lugar_all" : {
                        "icon"           : {
                            "image" : icons.lugar_all
                        },
                        "valid_children" : [ "" ]
                    }
                }
            },
            "themes"      : {
                "theme" : "default"
            },
            "search"      : {
                "case_insensitive" : true,
                "ajax"             : {
                    "type"   : "POST",
                    "url"    : "${createLink(action:'searchTree_ajax')}",
                    "data"   : function () {
                        return { search : this.data.search.str, tipo : current }
                    },
                    complete : function () {
                        $("#btnSearch").replaceWith(btn);
                        btn.click(function () {
                            doSearch();
                        });
                    }
                }
            },
            "contextmenu" : {
                select_node : true,
                "items"     : createContextmenu
            }, //contextmenu
            "ui"          : {
                "select_limit" : 1
            }
        }).bind("search.jstree",function (e, data) {
            var cant = data.rslt.nodes.length;
            var search = data.rslt.str;
            $("#cantRes").html("<b>" + cant + "</b> resultado" + (cant == 1 ? "" : "s"));
            if (cant > 0) {
                var container = $('#tree'), scrollTo = $('.jstree-search').first();
                container.animate({
                    scrollTop : scrollTo.offset().top - container.offset().top + container.scrollTop()
                }, 2000);
            }
        }).bind("select_node.jstree", function (NODE, REF_NODE) {
            refresh();
        });
    }

    function refresh() {
        var loading = $("<div></div>");
        loading.css({
            textAlign : "center",
            width     : "100%"
        });

        // loading.append("Cargando....Por favor espere...<br/>").append(spinnerBg);


        $("#info").html(loading);
        var node = $.jstree._focused().get_selected();
        var parent = node.parent().parent();

        var nodeStrId = node.attr("id");
        var nodeText = $.trim(node.children("a").text());

        var nodeRel = node.attr("rel");
        var parts = nodeRel.split("_");
        var nodeNivel = parts[0];
        var nodeTipo = parts[1];

        parts = nodeStrId.split("_");
        var nodeId = parts[1];

        var url = "";

        switch (nodeNivel) {
            case "grupo":
                url = "${createLink(action:'showGr_ajax')}";
                if (nodeTipo == "manoObra") {
                    url = "${createLink(action:'showSg_ajax')}";
                }
                break;
            case "subgrupo":
                url = "${createLink(action:'showSg_ajax')}";
                break;
            case "departamento":
                url = "${createLink(action:'showDp_ajax')}";
                break;
            case "item":
                url = "${createLink(action:'showIt_ajax')}";
                break;
            case "lugar":
                url = "${createLink(action:'showLg_ajax')}";
                nodeId = parts[1] + "_" + parts[2];
                break;
        }

        if (url != "") {
            $.ajax({
                type    : "POST",
                url     : url,
                data    : {
                    id       : nodeId,
                    all      : showLugar.all,
                    ignore   : showLugar.ignore,
                    fecha    : showLugar.fecha,
                    operador : showLugar.operador
                },
                success : function (msg) {
                    $("#info").html(msg);
                }
            });
        }
    }

    function doSearch() {
        var val = $.trim($("#search").val());
        if (val != "") {
            $("#btnSearch").replaceWith(sp);
            $("#tree").jstree("search", val);
        }
    }

    $(function () {

        $(".modal").draggable({
            handle : $(".modal-header"),
            cancel : '.btn, input, select'
        });

        $("#search").val("");

        $(".toggle").click(function () {
            var tipo = $(this).attr("id");
            if (tipo != current) {
//                        ////console.log(tipo);
                current = tipo;
                initTree(current);
                $("#info").html("");
            }
        });
        $(".toggleTipo").click(function () {
            var tipo = $(this).attr("id");
            if (!$(this).hasClass("active")) {
                showLugar[tipo] = true;
            } else {
                showLugar[tipo] = false;
            }
            initTree(current);
            $("#info").html("");
        });

        $(".fecha").click(function () {
            var op = $(this).data("operador");
            var text = $.trim($(this).text());
            var fecha = $(this).data("fecha");

            $("#spFecha").text(text);

            if (fecha) {
                $("#divFecha").show();
                var hoy = $("#fecha").datepicker("getDate");
                if (!hoy) {
                    hoy = new Date();
                    $("#fecha").datepicker("setDate", hoy);
                }
                showLugar.fecha = hoy.getDate() + "-" + (hoy.getMonth() + 1) + "-" + hoy.getFullYear();
            } else {
                showLugar.fecha = "all";
                $("#divFecha").hide();
            }
            showLugar.operador = op;
//                    ////console.log(showLugar);
        });

        initTree("1");
        $("#info").html("");

        $("#btnRefresh").click(function () {
            refresh();
        });

        $("#btnSearch").click(function () {
            doSearch();
        });

        $("#btnReporte").click(function () {
            var tipo = $.trim($("#" + current).data("reporte")).toLowerCase();
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'reportePreciosUI')}",
                data    : {
                    grupo : current
                },
                success : function (msg) {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success" data-dismiss="modal"><i class="icon-print"></i> Ver</a>');
                    var btnExcel = $('<a href="#" class="btn btnExcel" data-dismiss="modal"><i class="icon-table"></i> Excel</a>');

                    btnSave.click(function () {
                        var data = "";
                        data += "orden=" + $(".orden.active").attr("id");
                        data += "Wtipo=" + $(".tipo.active").attr("id");
                        data += "Wlugar=" + $("#lugarRep").val();
                        data += "Wfecha=" + $("#fechaRep").val();
                        data += "Wgrupo=" + current;

                        $(".col.active").each(function () {
                            data += "Wcol=" + $(this).attr("id");
                        });

                        var actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=Reporte_costos_" +
                            tipo + ".pdf&url=${createLink(controller: 'reportes2', action: 'reportePrecios')}";
                        location.href = actionUrl + "?" + data;

                        var wait = $("<div style='text-align: center;'> Estamos procesando su reporte......Por favor espere......</div>");
                        wait.prepend(spinnerBg);

                        var btnClose = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');

                        $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                        $("#modalTitle").html("Procesando");
                        $("#modalBody").html(wait);
                        $("#modalBody").close();
                        $("#modalFooter").html("").append(btnClose);

                        $.modal.close();

                        return false;
                    });

                    btnExcel.click(function () {

                        var fecha = $("#fechaRep").val();
                        var lugar = $("#lugarRep").val();
                        var grupo = current;

                        location.href = "${g.createLink(controller: 'reportes2', action: 'reportePreciosExcel')}?fecha=" +
                            fecha + "&lugar=" + lugar + "&grupo=" + grupo;
                    });

                    $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                    $("#modalTitle").html("Formato de impresión");
                    $("#modalBody").html(msg);
                    $("#modalFooter").html("").append(btnOk).append(btnSave).append(btnExcel);
                    $("#modal-tree").modal("show");
                }
            });
        });

        $("#search").keyup(function (ev) {
            if (ev.keyCode == 13) {
                doSearch();
            }
        });

        var cache = {};
        %{--$("#search").autocomplete({--}%
        %{--    minLength : 3,--}%
        %{--    source    : function (request, response) {--}%
        %{--        var term = request.term;--}%
        %{--        if (term in cache) {--}%
        %{--            response(cache[ term ]);--}%
        %{--            return;--}%
        %{--        }--}%

        %{--        $.ajax({--}%
        %{--            type     : "POST",--}%
        %{--            dataType : 'json',--}%
        %{--            url      : "${createLink(action: 'search_ajax')}",--}%
        %{--            data     : {--}%
        %{--                search : term,--}%
        %{--                tipo   : current--}%
        %{--            },--}%
        %{--            success  : function (data) {--}%
        %{--                cache[ term ] = data;--}%
        %{--                response(data);--}%
        %{--            }--}%
        %{--        });--}%

        %{--    }--}%
        %{--});--}%

    });
</script>

</body>
</html>
