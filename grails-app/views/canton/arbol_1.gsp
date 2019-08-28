<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>


    <asset:javascript src="/jstree-3.0.8/dist/jstree.min.js"/>
    <asset:stylesheet src="/jstree-3.0.8/dist/themes/default/style.min.css"/>

    <asset:javascript src="/jquery-validation-1.11.1/js/jquery.validate.min.js"/>
    <asset:javascript src="/jquery-validation-1.11.1/js/additional-methods.js"/>

    %{--        <script type="text/javascript"--}%
    %{--                src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>--}%
    %{--        <script type="text/javascript"--}%
    %{--                src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'additional-methods.js')}"></script>--}%
    %{--        <script type="text/javascript"--}%
    %{--                src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>--}%

    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree/_lib', file: 'jquery.hotkeys.js')}"></script>--}%
    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.cookie.js')}"></script>--}%
    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree', file: 'jquery.jstree.js')}"></script>--}%

    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>--}%
    %{--        <link href='${resource(dir: "js/jquery/plugins/box/css", file: "jquery.luz.box.css")}' rel='stylesheet' type='text/css'>--}%

    <title>División Política de la Provincia de Pichincha</title>


    <style type="text/css">
    .div {
        width      : 424px;
        min-height : 150px;
        border     : solid 3px #768CC1;
        padding    : 5px;
        background : #EAF2FF !important;
    }

    .info {
        margin-left : 15px;
    }

    #infoCont {
        margin-top : 5px;
    }

    .label {
        padding     : 0 5px 0 15px;
        font-weight : bold;
    }

    .scroll {
        overflow-x : hidden !important;
        overflow-y : hidden;
    }

    </style>

</head>

<body>
<div class="dialog">

    <div class="body">
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>

        <div id="tree" class="div left ui-corner-all"
             style="height:600px; width: 400px;overflow-y: auto">

        </div>

        <div id="info" class="div info left ui-corner-all" style="margin-left: 420px; margin-top: -615px">
            <div id="infoTitle"></div>

            <div id="infoCont"></div>
        </div>

        <div id="dlg_editar"></div>

    </div> <!-- body -->
</div> <!-- dialog -->

<script type="text/javascript">

    var icons = {
        add       : $('<asset:image src="ico/Add.png"/>'),
        edit      : $('<asset:image src="ico/Edit.png"/>'),
        remove    : $('<asset:image src="ico/Delete.png"/>'),
        pais      : $('<asset:image src="ico/pais.png"/>'),
        zona      : $('<asset:image src="ico/zona.png"/>'),
        provincia : $('<asset:image src="ico/provincia_32.png"/>'),
        canton    : $('<asset:image src="ico/canton.png"/>'),
        parroquia : $('<asset:image src="ico/parroquia.png"/>'),
        comunidad : $('<asset:image src="ico/comunidad.png"/>')

    };

    var lrg_icons = {
        add       : $('<asset:image src="ico/Add.png"/>'),
        edit      : $('<asset:image src="ico/Edit.png"/>'),
        remove    : $('<asset:image src="ico/Delete.png"/>'),
        pais      : $('<asset:image src="ico/pais.png"/>'),
        zona      : $('<asset:image src="ico/zona_32.png"/>'),
        provincia : $('<asset:image src="ico/provincia_32.png"/>'),
        canton    : $('<asset:image src="ico/canton_32.png"/>'),
        parroquia : $('<asset:image src="ico/parroquia_32.png"/>'),
        comunidad : $('<asset:image src="ico/comunidad.png"/>')
    };

    function createContextmenu(node) {

        var parent = node.parent().parent();

        var textNode = $.trim(node.children("a").text());
        var textParent = $.trim(parent.children("a").text());

        var strIdNode = node.attr("id");
        var strIdParent = parent.attr("id");

        var parts = strIdNode.split("_");
        var idNode = parts[1];
        parts = strIdParent.split("_");
        var idParent = parts[1];

        var tipoNode = node.attr("rel");
        var tipoParent = parent.attr("rel");

        var submenu;

        switch (tipoNode) {
            case "provincia" :
                submenu = {
                    "canton" : {
                        "label"  : "Cantón",
                        "action" : function (obj) {
                            var url = "${createLink(controller: 'canton', action: 'editar')}";
                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo"      : "canton",
                                    "crear"     : true,
                                    "padre"     : idNode,
                                    "tipoPadre" : tipoNode
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Crear cantón en la " + tipoNode + " " + textNode);
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            }); //ajax
                        }, //action canton
                        "icon"   : icons.canton
                    } //canton
                };
                break;
            case "canton":
                submenu = {
                    "canton"    : {
                        "label"  : "Cantón",
                        "action" : function (obj) {
                            var url = "${createLink(controller: 'canton', action: 'editar')}";
                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo"      : "canton",
                                    "crear"     : true,
                                    "padre"     : idParent,
                                    "tipoPadre" : tipoParent
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Crear cantón en la " + tipoParent + " " + textParent);
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");

                                }
                            }); //ajax
                        }, //action canton
                        "icon"   : icons.canton
                    }, //canton
                    "parroquia" : {

                        "label"  : "Parroquia",
                        "action" : function (obj) {
                            var url = "${createLink(controller: 'canton', action: 'editar')}";
                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo"  : "parroquia",
                                    "crear" : true,
                                    "padre" : idNode
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Crear parroquia en el cantón " + textNode);
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            }); //ajax
                        }, //action parroquia
                        "icon"   : icons.parroquia
                    }//parroquia
                };
                break;
            case "parroquia":
                submenu = {
                    "parroquia" : {
                        "label"  : "Parroquia",
                        "action" : function (obj) {
                            var url = "${createLink(controller: 'canton', action: 'editar')}";
                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo"      : "parroquia",
                                    "crear"     : true,
                                    "padre"     : idParent,
                                    "tipoPadre" : tipoParent
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Crear parroquia en el cantón " + textParent);
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            }); //ajax
                        }, //action parroquia
                        "icon"   : icons.parroquia
                    }, //parroquia
                    "comunidad" : {
                        "label"  : "Comunidad",
                        "action" : function (obj) {
                            var url = "${createLink(controller: 'canton', action: 'editar')}";
                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo"  : "comunidad",
                                    "crear" : true,
                                    "padre" : idNode
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Crear comunidad en la parroquia " + textNode);
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            }); //ajax
                        },
                        "icon"   : icons.comunidad
                    } //parroquia
                };
                break;
            case "comunidad":
                submenu = {
                    "comunidad" : {
                        "label"  : "Comunidad",
                        "action" : function (obj) {
                            var url = "${createLink(controller: 'canton', action: 'editar')}";
                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo"      : "comunidad",
                                    "crear"     : true,
                                    "padre"     : idParent,
                                    "tipoPadre" : tipoParent
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Crear comunidad en la parroquia " + textNode);
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            }); //ajax
                        },
                        "icon"   : icons.comunidad
                    } //parroquia
                }
        }

        var nuevo = {
            "label"            : "Crear",
            "_disabled"        : false,        // clicking the item won't do a thing
            "_class"           : "class",    // class is applied to the item LI node
            "separator_before" : false,    // Insert a separator before the item
            "separator_after"  : true,        // Insert a separator after the item
            "icon"             : icons.add,
            "submenu"          : submenu //submenu
        };
        var items = {
            "create" : false,
            "remove" : false,
            "rename" : false,
            "ccp"    : false,

            "nuevo" : nuevo //nuevo
        }; //items

        if (tipoNode != "provincia") {
            items.editar = {
                // The item label
                "label"            : "Editar",
                // The function to execute upon a click
                "action"           : function (obj) {
                    var tipo = $(obj).attr("rel");
                    var str = $(obj).attr("id");
                    var parts = str.split("_");
                    var id = parts[1];
                    var url = "${createLink(controller: 'canton', action: 'editar')}";

                    $.ajax({
                        "type"    : "POST",
                        "url"     : url,
                        "data"    : {
                            "tipo"      : tipo,
                            "id"        : id,
                            "tipoPadre" : tipoParent
                        },
                        "success" : function (msg) {
                            $("#dlg_editar").dialog("option", "title", "Editar " + ((tipo == "canton") ? "cantón" : tipo));
                            $("#dlg_editar").html(msg);
                            $("#dlg_editar").dialog("open");
                        }
                    });

                },
                // All below are optional
                "_disabled"        : false,        // clicking the item won't do a thing
                "_class"           : "class",    // class is applied to the item LI node
                "separator_before" : false,    // Insert a separator before the item
                "separator_after"  : false,        // Insert a separator after the item
                // false or string - if does not contain `/` - used as classname
                "icon"             : icons.edit
            }; //editar

            items.eliminar = {
                // The item label
                "label"            : "Eliminar",
                // The function to execute upon a click
                "action"           : function (obj) {
                    var tipo = $(obj).attr("rel");
                    var str = "";
                    switch (tipo) {
                        case "zona":
                            str = "Está seguro de querer eliminar esta zona?\nEsta acción no se puede deshacer...";
                            break;
                        case "provincia":
                            str = "Está seguro de querer eliminar esta provincia?\nEsta acción no se puede deshacer...";
                            break;
                        case "canton":
                            str = "Está seguro de querer eliminar este cantón?\nEsta acción no se puede deshacer...";
                            break;
                        case "parroquia":
                            str = "Está seguro de querer eliminar esta parroquia?\nEsta acción no se puede deshacer...";
                            break;
                        case "comunidad":
                            str = "Está seguro de querer eliminar esta comunidad?\nEsta acción no se puede deshacer...";
                            break;

                    }

                    if (confirm(str)) {
                        var str = $(obj).attr("id");
                        var parts = str.split("_");
                        var id = parts[1];

                        var url = "${createLink(action: 'deleteFromTree')}";
                        $.ajax({
                            "type"    : "POST",
                            "url"     : url,
                            "data"    : {
                                tipo : tipo,
                                id   : id
                            },
                            "success" : function (msg) {
                                //////console.log(msg)

                                if (msg == "OK") {
                                    $("#infoCont").html("");
                                    $("#infoTitle").html("");
//                                    reloadTree();
                                    window.location.reload(true);
                                } else {
                                    alert(msg);
                                }
                            }
                        });
                    }
                },
                // All below are optional
                "_disabled"        : false,        // clicking the item won't do a thing
                "_class"           : "class",    // class is applied to the item LI node
                "separator_before" : false,    // Insert a separator before the item
                "separator_after"  : false,        // Insert a separator after the item
                // false or string - if does not contain `/` - used as classname
                "icon"             : icons.remove
            }; //eliminar
        }
        return items;
    } //createContextmenu

    function initTree() {
        $("#tree").jstree({
            "plugins"     : ["themes", "html_data", "ui", "hotkeys", "cookies", "types", "contextmenu", "json_data", "search"/*, "crrm", "wholerow"*/],
            open_parents  : false,
            "html_data"   : {
                "data" : "<ul type='provincia'><li id='provincia_1' class='provincia jstree-closed' rel='provincia'><a href='#' class='label_arbol'>Pichincha</a></ul>",
                "ajax" : {
                    "url"   : "${createLink(action: 'loadTreePart')}",
                    "data"  : function (n) {
                        var obj = $(n);
                        var id = obj.attr("id");
                        var parts = id.split("_");
                        var tipo = parts[0];
                        var id = 0;
                        if (parts.length > 1) {
                            id = parts[1]
                        }
                        return {tipo : tipo, id : id}
                    },
                    success : function (data) {
                    },
                    error   : function (data) {
                    }
                }
            },
            "types"       : {
                "valid_children" : [ "root" ],
                "types"          : {

                    "provincia" : {
                        "icon"           : {
                            "image" : icons.provincia
                        },
                        "valid_children" : [ "canton" ]
                    },
                    "canton"    : {
                        "icon"           : {
                            "image" : icons.canton
                        },
                        "valid_children" : ["parroquia"]
                    },
                    "parroquia" : {
                        "icon"           : {
                            "image" : icons.parroquia
                        },
                        "valid_children" : ["comunidad"]
                    },
                    "comunidad" : {
                        "icon"           : {

                            "image" : icons.comunidad

                        },
                        "valid_children" : [" "]
                    }
                }
            },
            "themes"      : {
                "theme" : "default"
            },
            "contextmenu" : {
                select_node : true,
                "items"     : createContextmenu
            }, //contextmenu
            "ui"          : {
                "select_limit" : 1
            }
        })//js tree
            .bind("select_node.jstree", function (event, data) {
                var obj = data.rslt.obj;
                $("#tree").jstree("toggle_node", "#" + obj.attr("id"));
                var title = obj.children("a").text();
                var tipo = $(obj).attr("rel");
                var str = $(obj).attr("id");
                var parts = str.split("_");
                var id = parts[1];

                var img = "<img src='" + lrg_icons[tipo] + "' alt='" + tipo + "' />";
                $("#infoTitle").html("<h1>" + img + "  " + title + "</h1>");

                var url = "${createLink(action: 'infoForTree')}";
                $.ajax({
                    "type"    : "POST",
                    "url"     : url,
                    "data"    : {
                        tipo : tipo,
                        id   : id
                    },
                    "success" : function (msg) {
                        $("#infoCont").html(msg);
                    },
                    "error"   : function () {
                        $("#infoCont").html("");
                    }
                }); //ajax
            }); //click en los nodos

        var h = $("#tree").height();
        var h2 = $("#info").height();

        var extra = 0;

        $("#info").height(Math.max(h, h2) + extra);
        $("#tree").height(Math.max(h, h2) + extra);

    } //init tree

    function reloadTree() {
    }

    $(function () {
%{--        $("#dlg_editar").dialog({--}%
%{--            autoOpen    : false,--}%
%{--            modal       : true,--}%
%{--            width       : 700,--}%
%{--            buttons     : {--}%
%{--                "Cancelar" : function () {--}%
%{--                    $("#dlg_editar").dialog("close");--}%
%{--                },--}%
%{--                "Guardar"  : function () {--}%
%{--                    var url = "${createLink(action: 'saveFromTree')}";--}%
%{--                    if ($(".frm_editar").valid()) {--}%
%{--                        var data = $(".frm_editar").serialize();--}%
%{--                        $.ajax({--}%
%{--                            "type"    : "POST",--}%
%{--                            "url"     : url,--}%
%{--                            "data"    : data,--}%
%{--                            "success" : function (msg) {--}%
%{--                                if (msg == "OK") {--}%
%{--//                                    reloadTree();--}%
%{--                                    $('.jstree-clicked').click();--}%
%{--                                    $("#dlg_editar").dialog("close");--}%
%{--                                    window.location.reload(true);--}%
%{--                                } else {--}%
%{--                                    $.box({--}%
%{--                                        imageClass : "box_info",--}%
%{--                                        text       : msg,--}%
%{--                                        title      : "ERROR",--}%
%{--                                        iconClose  : false,--}%
%{--                                        dialog     : {--}%
%{--                                            resizable     : false,--}%
%{--                                            draggable     : false,--}%
%{--                                            closeOnEscape : false,--}%
%{--                                            buttons       : {--}%
%{--                                                "Aceptar" : function () {--}%
%{--                                                }--}%
%{--                                            }--}%
%{--                                        }--}%
%{--                                    });--}%
%{--                                }--}%
%{--                            }--}%
%{--                        });--}%
%{--                    }--}%
%{--                }--}%
%{--            },--}%
%{--            beforeClose : function () {--}%
%{--                $(".ui-tooltip-rounded").hide();--}%
%{--                return true;--}%
%{--            }--}%
%{--        });--}%
        initTree();
    });
</script>

</body>
</html>